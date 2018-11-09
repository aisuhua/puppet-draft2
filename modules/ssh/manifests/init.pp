class ssh {

  package { 'openssh-server':
    ensure => installed,
  }

  augeas { 'sshd_config':
    context => '/files/etc/ssh/sshd_config',
    changes => [
      "set Port ${config::ssh_port}",
      "set PermitRootLogin ${config::ssh_permit_root_login}",
    ],
    require => Package['openssh-server']
  }

  service { 'ssh':
    enable => true,
    ensure => running,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => Augeas['sshd_config'];
  }
}
