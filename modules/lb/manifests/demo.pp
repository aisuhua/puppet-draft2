class lb::demo {

  file { '/etc/nginx/sites-enabled/demo.conf':
    ensure => file,
    source => 'puppet:///modules/lb/demo.conf',
    require => Package['nginx'],
    notify => Exec['nginx-reload']
  }
}