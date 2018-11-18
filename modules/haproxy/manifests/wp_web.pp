class haproxy::wp_web {

  file { '/etc/haproxy/haproxy.cfg':
    ensure  => file,
    content  => template('haproxy/haproxy.cfg.erb', 'haproxy/wp_web.cfg.erb'),
    require => Package['haproxy'],
    notify => Exec['haproxy-reload']
  }
}