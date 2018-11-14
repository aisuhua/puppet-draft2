node default {

  package {
    [
      'python-software-properties',
      'augeas-tools'
    ]:
      ensure => installed
  }

  accounts::user { 'aisuhua':
    groups => ['aisuhua','sudo'],
    shell => '/bin/bash',
    password => '$1$6Weoolps$Yrx/B8XND7xgmPtvp3sna.',
    locked => false
  }

  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure => file,
    content => '*.aisuhua.net'
  }

  augeas { 'ssh_config':
    context => '/files/etc/ssh/ssh_config/Host',
    changes => [
      "set StrictHostKeyChecking no"
    ],
    require => Package['augeas-tools']
  }

  include pssh
}