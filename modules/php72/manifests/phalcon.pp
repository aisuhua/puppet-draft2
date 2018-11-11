class php72::phalcon {

  package { 'php-phalcon':
    ensure  => installed,
    require => Package['php7.2-dev'],
    notify => Service['php7.2-fpm'],
  }
}