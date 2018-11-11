class rsync {

  package { 'rsync':
    ensure => installed;
  }

  augeas { 'rsync':
    context => '/files/etc/default/rsync',
    changes => [
      "set RSYNC_ENABLE true"
    ],
    require => Package['rsync']
  }

  file { '/etc/rsyncd.conf':
    ensure => file,
    source => 'puppet:///modules/rsync/rsyncd.conf',
    require => Augeas['rsync'],
    notify => Service['rsync'],
  }

  service { 'rsync':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Augeas['rsync']
  }
}
