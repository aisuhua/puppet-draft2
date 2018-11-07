class nginx {

  # https://launchpad.net/~nginx/+archive/ubuntu/stable
  apt::ppa { 'ppa:nginx/stable': }

  package { 'nginx':
      ensure => installed,
      require => Apt::Ppa['ppa:nginx/stable']
  }
}