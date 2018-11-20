class haproxy::wp {

  file { '/etc/haproxy/haproxy.cfg':
    ensure  => file,
    content  => template('haproxy/haproxy.cfg.erb', 'haproxy/wp.cfg.erb'),
    require => Package['haproxy'],
    notify => Exec['haproxy-reload']
  }
}