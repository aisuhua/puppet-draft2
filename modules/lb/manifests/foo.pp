class lb::foo {

  file { '/etc/nginx/sites-enabled/foo.conf':
    ensure => file,
    # source => 'puppet:///modules/lb/foo.conf',
    content => template('lb/foo.conf.erb'),
    require => Package['nginx'],
    notify => Exec['nginx-reload']
  }
}