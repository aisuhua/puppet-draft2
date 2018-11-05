class base {

  # 使用中科大镜像
  file { '/etc/apt/sources.list':
    ensure => file,
    source => "puppet:///modules/base/sources.list"
  }

  # 更新源
  exec { 'aptgetupdate':
    path => '/usr/bin',
    command => 'apt-get update',
    subscribe => File['/etc/apt/sources.list'],
    refreshonly => true
  }

  # 创建项目目录和机房标识文件
  file {
    default:
      group => 'www-data',
      owner => 'www-data',;
    '/www':
      ensure => directory,;
    '/www/web':
      ensure => directory,;
    '/www/web/IDC_HN1':
      ensure => file,
      content => 'HUANAN1',
      mode => '0644',;
  }

  # 安装基础软件
  package { ['python-software-properties', 'ruby-dev', 'build-essential', 'sysstat', 'lsb-release']:
    ensure => installed,
  }

  # 消息压缩用到
  package { 'msgpack':
    ensure => installed,
    provider => gem,
  }

  # 安装、配置和启动 ssh
  include ssh
  # 安装、配置和设置定时更新 ntpdate
  include ntpdate
  # 添加用户 suhua 和 youtube
  include user::aisuhua
  include user::youtube

}
