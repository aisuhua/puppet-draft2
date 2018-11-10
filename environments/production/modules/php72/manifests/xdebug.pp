class php72::xdebug {

  package { 'php-xdebug':
    ensure  => installed,
    require => Package['php7.2-dev'],
    notify => Service['php7.2-fpm'],
  }
}