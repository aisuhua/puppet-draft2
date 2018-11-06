class php72::yar {

  exec { 'install_yar':
    path => '/bin:/usr/bin',
    command => 'pecl install yar',
    require => Package['php7.2-dev'],
    unless => 'pecl list | grep yar'
  }

  # https://ask.puppet.com/question/5849/check-if-file-exists-on-client/
  # exec { 'create_yar_ini':
  #   path => '/bin:/usr/bin',
  #   command => "echo 'extension=yar.so' > /etc/php/7.2/mods-available/yar.ini",
  #   require => Exec['install_yar'],
  #   unless => 'test -f /etc/php/7.2/mods-available/yar.ini'
  # }

  file { '/etc/php/7.2/mods-available/yar.ini':
    ensure => file,
    content => "extension=yar.so\n",
    require => Exec['install_yar'],
  }

  file { '/etc/php/7.2/fpm/conf.d/20-yar.ini':
    ensure => link,
    target => '/etc/php/7.2/mods-available/yar.ini',
    require => File['/etc/php/7.2/mods-available/yar.ini'],
    notify => Service['php7.2-fpm']
  }

  file { '/etc/php/7.2/cli/conf.d/20-yar.ini':
    ensure => link,
    target => '/etc/php/7.2/mods-available/yar.ini',
    require => File['/etc/php/7.2/mods-available/yar.ini']
  }

  # exec { 'ln_fpm_yar_ini':
  #   path => '/bin:/usr/bin',
  #   command => "ln -s /etc/php/7.2/mods-available/yar.ini /etc/php/7.2/fpm/conf.d/20-yar.ini",
  #   require => Exec['create_yar_ini'],
  #   unless => 'test -f /etc/php/7.2/fpm/conf.d/20-yar.ini'
  # }

  # exec { 'ln_cli_yar_ini':
  #   path => '/bin:/usr/bin',
  #   command => "ln -s /etc/php/7.2/mods-available/yar.ini /etc/php/7.2/cli/conf.d/20-yar.ini",
  #   require => Exec['create_yar_ini'],
  #   unless => 'test -f /etc/php/7.2/cli/conf.d/20-yar.ini'
  # }
}