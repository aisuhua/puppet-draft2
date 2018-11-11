class system {

  file { '/etc/systemd/system.conf':
    ensure => file,
    source  => 'puppet:///modules/system/system.conf',
  }
}