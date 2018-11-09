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

  # 启动 nginx
  service { 'nginx':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package['nginx']
  }

  # reload 配置
  contain nginx::reload
}