class nginx {

  # https://launchpad.net/~nginx/+archive/ubuntu/stable
  apt::ppa { 'ppa:nginx/stable': }

  exec { "update-nginx-stable":
    path => '/usr/bin:/bin',
    command => "apt-get update",
    subscribe => Apt::Ppa['ppa:nginx/stable'],
    refreshonly => true
  }

  package { 'nginx':
    ensure => installed,
    require => Exec['update-nginx-stable']
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => absent,
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/sites-available/status.conf':
    ensure => file,
    source => 'puppet:///modules/nginx//status.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }

  # 启动 nginx
  service { 'nginx':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package['nginx']
  }
}