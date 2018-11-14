class pssh {

  exec { 'download-pssh':
    path => '/bin:/usr/bin',
    command => "wget https://github.com/lilydjwg/pssh/archive/v2.3.1.tar.gz",
    cwd => '/tmp',
    unless => 'test -f /usr/local/bin/pssh'
  }

  exec { 'untar-pssh':
    path => '/bin:/usr/bin',
    command => "tar -zxvf v2.3.1.tar.gz",
    cwd => '/tmp',
    subscribe => Exec['download-pssh'],
    refreshonly => true,
  }

  exec { 'install-pssh':
    path => '/bin:/usr/bin',
    command => "python setup.py install",
    cwd => '/tmp/pssh-2.3.1',
    require => Package['python-software-properties'],
    subscribe => Exec['untar-pssh'],
    refreshonly => true
  }

  file {
    '/tmp/v2.3.1.tar.gz':
      ensure => absent;
    '/tmp/pssh-2.3.1':
      ensure => absent;
  }
}