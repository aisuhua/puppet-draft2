class ssh {

  $port = lookup('ssh::port');
  $permit_root_login = lookup('ssh::permit_root_login');

  package { 'openssh-server':
    ensure => installed,
  }

  augeas { 'sshd_config':
    context => '/files/etc/ssh/sshd_config',
    changes => [
      "set Port ${port}",
      "set PermitRootLogin ${permit_root_login}",
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
