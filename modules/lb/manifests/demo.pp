class lb::demo {

  file { '/etc/nginx/sites-enabled/demo.conf':
    ensure => file,
    content => template('lb/demo.conf.erb'),
    require => Package['nginx'],
    notify => Exec['nginx-reload']
  }
}