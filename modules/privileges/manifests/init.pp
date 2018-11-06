class privileges {

  # Purge current sudo config
  # https://github.com/saz/puppet-sudo
  class { 'sudo': }

  # 授予 aisuhua 免密 sudo 切换用户权限
  sudo::conf { 'aisuhua':
    ensure  => present,
    content => 'aisuhua ALL=(ALL:ALL) NOPASSWD: ALL',
  }
}