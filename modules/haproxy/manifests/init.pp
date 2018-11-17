class haproxy {

  package { 'haproxy':
    ensure => installed
  }

  service { 'haproxy':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus=> true
  }
}