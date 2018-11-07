class php72 {

  apt::ppa { 'ppa:ondrej/php': }

  exec { "update-ondrej-php":
    path => '/usr/bin:/bin',
    command => "apt-get update",
    subscribe => Apt::Ppa['ppa:ondrej/php'],
    refreshonly => true,
    unless => 'apt-cache search php7.2-dev'
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

  # 优化 php.ini 配置
  augeas { 'fpm/php.ini':
    context => '/files/etc/php/7.2/fpm/php.ini/PHP',
    changes => [
      "set upload_max_filesize 30M",
      "set post_max_size 30M",
    ],
    require => Package['php7.2-fpm'],
    notify => Service['php7.2-fpm']
  }

  augeas { 'cli/php.ini':
    context => '/files/etc/php/7.2/cli/php.ini/PHP',
    changes => [
      "set upload_max_filesize 30M",
      "set post_max_size 30M",
    ],
    require => Package['php7.2-cli']
  }

  # 优化 PHP-FPM 配置
  augeas { 'www.conf':
    context => '/files/etc/php/7.2/fpm/pool.d/www.conf/www',
    changes => [
      "set user www-data",
      "set group www-data",
      "set listen 127.0.0.1:9000",
      "set listen.owner www-data",
      "set listen.group www-data",
      "set pm static",
      "set pm.max_children 200",
      "set pm.max_requests 200",
      "set pm.status_path /phpfpm_status",
      "set ping.path /phpfpm_ping",
      "set chdir /",
      # "set slowlog /var/log/phpfpm_slow.log",
      # "set request_slowlog_timeout 1s",
      # "set request_terminate_timeout 0",
    ],
    require => Package['php7.2-fpm'],
    notify => Service['php7.2-fpm']
  }

  # 启动 PHP-FPM
  service { 'php7.2-fpm':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package['php7.2-fpm']
  }
}