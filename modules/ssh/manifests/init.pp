class ssh {

  package { 'openssh-server':
    ensure => installed,
  }

  augeas { 'sshd_config':
    context => '/files/etc/ssh/sshd_config',
    changes => [
      "set Port 25680",
      "set PermitRootLogin yes",
    ]
  }

  service { 'ssh':
    enable => true,
    ensure => running,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Augeas['sshd_config'];
  }
}
