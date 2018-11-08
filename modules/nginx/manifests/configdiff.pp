class nginx::configdiff {

  file { '/etc/nginx/sites-enabled/default':
    ensure => absent,
    require => Package['nginx'],
    notify => Service['nginx']
  }
}