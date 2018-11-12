class php72 {

  apt::ppa { 'ppa:ondrej/php': }

  # apt::source does not force an 'apt-get update' and fails on first run
  # https://tickets.puppetlabs.com/browse/MODULES-2190
  # https://github.com/puppetlabs/puppetlabs-apt#limitations
  exec { "update-ondrej-php":
    path => '/usr/bin:/bin',
    command => "apt-get update",
    subscribe => Apt::Ppa['ppa:ondrej/php'],
    refreshonly => true
  }

  package {
    [
      'php7.2-common',
      'php7.2-dev',
      'php7.2-cli',
      'php7.2-fpm',
      'php7.2-xml',
      'php7.2-curl',
      'php7.2-mbstring',
      'php7.2-bcmath',
      'php7.2-gd',
      'php7.2-bz2',
      'php7.2-zip',
      'php7.2-dba',
      'php7.2-mysql',
      'php7.2-soap',
      'php-pear',
      'php-imagick',
      'php-msgpack',
      'php-igbinary',
      'php-mongodb',
      'php-memcache',
      'php-memcached',
      'php-redis',
      'php-amqp',
    ]:
      ensure => installed,
      require => Exec['update-ondrej-php']
  }

  # 设置 PHP 默认版本
  exec { 'update-alternatives-php7.2':
    path => '/bin:/usr/bin:/usr/sbin',
    require => Package['php7.2-cli'],
    unless => 'php -v | grep -q 7.2',
    command => "update-alternatives --set php /usr/bin/php7.2;
    update-alternatives --set php-config /usr/bin/php-config7.2;
    update-alternatives --set phpize /usr/bin/phpize7.2;"
  }

  contain php72::config

  # 启动 PHP-FPM
  service { 'php7.2-fpm':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package['php7.2-fpm']
  }
}