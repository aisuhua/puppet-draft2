class vim {

  file { '/etc/vim/vimrc.local':
    ensure => file,
    content => 'set tabstop=4'
  }
}