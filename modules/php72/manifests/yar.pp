class php72::yar {

  exec { 'php-yar':
    path => '/bin:/usr/bin',
    command => 'pecl install yar',
    require => Package['php7.2-dev'],
    unless => 'pecl list | grep yar'
  }

  file { '/etc/php/7.2/mods-available/yar.ini':
    ensure => file,
    content => "extension=yar.so\n",
    require => Exec['php-yar'],
  }

  file { '/etc/php/7.2/fpm/conf.d/20-yar.ini':
    ensure => link,
    target => '/etc/php/7.2/mods-available/yar.ini',
    require => File['/etc/php/7.2/mods-available/yar.ini'],
    notify => Service['php7.2-fpm']
  }

  file { '/etc/php/7.2/cli/conf.d/20-yar.ini':
    ensure => link,
    target => '/etc/php/7.2/mods-available/yar.ini',
    require => File['/etc/php/7.2/mods-available/yar.ini']
  }
}