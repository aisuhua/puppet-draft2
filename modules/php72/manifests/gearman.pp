class php72::gearman {

  apt::ppa { 'ppa:ondrej/pkg-gearman': }

  exec { "update-ondrej-pkg-gearman":
    path => '/usr/bin:/bin',
    command => "apt-get update",
    subscribe => [Apt::Ppa['ppa:ondrej/pkg-gearman']],
    refreshonly => true
  }

  package { 'php-gearman':
    ensure => installed,
    require => [
      Package['php7.2-dev'],
      Exec['update-ondrej-pkg-gearman']
    ],
    notify => Service['php7.2-fpm']
  }
}