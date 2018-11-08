class base {

  # 修改 hosts
  include hosts

  # 修改 DNS
  include resolver

  # 创建项目目录和机房标识文件
  file {
    default:
      group => 'www-data',
      owner => 'www-data';
    '/www':
      ensure => directory;
    '/www/web':
      ensure => directory;
    '/www/web/IDC_HN1':
      ensure => file,
      content => 'HUANAN1',
      mode => '0644';
  }

  # 安装基础软件
  package {
    [
      'python-software-properties',
      'ruby-dev',
      'build-essential',
      'sysstat',
      'lsb-release',
      'curl',
      'libcurl4-gnutls-dev',
      'dirmngr',
      'augeas-tools'
    ]:
    ensure => installed,
  }

  # Fix php7 FPM support
  # https://github.com/hercules-team/augeas/commit/428e3c7961657f211e3427b22ad72119068ae2ca
  file { '/usr/share/augeas/lenses/dist/php.aug':
    ensure => file,
    source => "puppet:///modules//base/php.aug",
    require => Package['augeas-tools']
  }

  # 用于消息传输的压缩
  package { 'msgpack':
    ensure => installed,
    provider => gem,
  }

  # 安装、配置和启动 ssh
  include ssh

  # 安装、配置和定时校准时间 ntpdate
  include ntpdate

  # 优化系统内核参数
  include sysctl

  # 增加文件描述符限制
  include limits
  include system

  # 添加 suhua 和 dba 用户
  include user::aisuhua
  include user::dba

  # 用户授权
  include privileges

  # 使用国内镜像
  include apt
  # include sourcelist # 有问题暂不启用
}
