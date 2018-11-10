class php72::couchbase {

  # 安装 couchbase-release https://github.com/aisuhua/wiki/tree/master/php#couchbase
  # download
  exec { 'download-couchbase-release':
    path => '/bin:/usr/bin',
    command => "wget -P /tmp http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-4-amd64.deb",
    unless => 'dpkg -l | grep couchbase-release'
  }

  # install
  package { 'couchbase-release':
    ensure => installed,
    provider => dpkg,
    source => '/tmp/couchbase-release-1.0-4-amd64.deb',
    require => Exec['download-couchbase-release'],
  }

  # clear
  file { '/tmp/couchbase-release-1.0-4-amd64.deb':
    ensure => absent,
    require => Package['couchbase-release']
  }

  # apt-get update
  exec { 'update-couchcase-release':
    path => '/bin:/usr/bin',
    command => "apt-get update",
    subscribe => Package['couchbase-release'],
    refreshonly => true
  }

  # install libcouchbase
  package { ['libcouchbase-dev', 'zlib1g-dev']:
    ensure => installed,
    require => [
      Package['build-essential'],
      Package['php7.2-dev']
    ]
  }

  # 安装 PHP 的 couchbase 客户端扩展
  exec { 'php-couchbase':
    path => '/bin:/usr/bin',
    command => 'pecl install couchbase',
    require => Package['php7.2-dev'],
    unless => 'pecl list | grep couchbase'
  }

  file { '/etc/php/7.2/mods-available/couchbase.ini':
    ensure => file,
    content => "extension=couchbase.so\n",
    require => Exec['php-couchbase'],
  }

  file { '/etc/php/7.2/fpm/conf.d/25-couchbase.ini':
    ensure => link,
    target => '/etc/php/7.2/mods-available/couchbase.ini',
    require => File['/etc/php/7.2/mods-available/couchbase.ini'],
    notify => Service['php7.2-fpm']
  }

  file { '/etc/php/7.2/cli/conf.d/25-couchbase.ini':
    ensure => link,
    target => '/etc/php/7.2/mods-available/couchbase.ini',
    require => File['/etc/php/7.2/mods-available/couchbase.ini']
  }
}