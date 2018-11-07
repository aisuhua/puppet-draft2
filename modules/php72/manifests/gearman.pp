class php72::gearman {

  apt::ppa { 'ppa:ondrej/pkg-gearman': }

  package { 'php-gearman':
    ensure => installed,
    require => [
      Package['php7.2-dev'],
      Apt::Ppa['ppa:ondrej/pkg-gearman']
    ],
    notify => Service['php7.2-fpm']
  }
}