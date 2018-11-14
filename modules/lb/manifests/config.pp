class lb::config {

  file { '/etc/nginx/conf.d':
    ensure => directory,
    source => 'puppet:///modules/lb/conf.d',
    recurse => true,
    require => Package['nginx'],
    notify => Service['nginx']
  }

  # nginx.conf
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/lb/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }
}