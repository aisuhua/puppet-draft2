class nginx::config {

  file { '/etc/nginx/sites-enabled/default':
    ensure => absent,
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/sites-available/headers.conf':
    ensure => file,
    content => template('nginx/headers.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/sites-available/status.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/status.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }
}