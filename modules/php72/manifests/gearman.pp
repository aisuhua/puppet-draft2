class php72 {

  apt::ppa { 'ppa:ondrej/pkg-gearman': }

  exec { "update_ondrejpkggearman":
    path => '/usr/bin:/bin',
    command => "apt-get update",
    subscribe => [Apt::Ppa['ppa:ondrej/pkg-gearman']],
    refreshonly => true
  }

  package { 'php-gearman':
    ensure => installed,
    require => [
      Package['php7.2-dev'],

    ],
    notify => Service['php7.2-fpm']
  }
}