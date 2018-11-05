class base {

  # 修改 DNS
  # https://puppet.com/docs/puppet/5.5/quick_start_dns.html
  $nameservers = ['223.5.5.5', '223.6.6.6']

  file { '/etc/resolv.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('resolver/resolv.conf.erb'),
  }

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
  package { ['python-software-properties', 'ruby-dev', 'build-essential', 'sysstat', 'lsb-release']:
    ensure => installed,
  }

  # 安装 augtool
  package { ['augeas-tools']:
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

  # 添加 suhua 和 youtube 用户
  include user::aisuhua
  include user::dba
  # 用户授权
  include privileges

  # 优化系统内核参数
  augeas { 'sysctl.conf':
    context => '/files/etc/sysctl.conf',
    changes => [
      "set vm.swappiness 0",
      "set net.ipv4.neigh.default.gc_stale_time 120",
      "set net.ipv4.conf.all.rp_filter 0",
      "set net.ipv4.conf.default.rp_filter 0",
      "set net.ipv4.conf.default.arp_announce 2",
      "set net.ipv4.conf.lo.arp_announce 2",
      "set net.ipv4.conf.all.arp_announce 2",
      "set net.ipv4.tcp_max_tw_buckets 5000",
      "set net.ipv4.tcp_syncookies 1",
      "set net.ipv4.tcp_max_syn_backlog 1024",
      "set net.ipv4.tcp_synack_retries 2",
      "set net.ipv6.conf.all.disable_ipv6 1",
      "set net.ipv6.conf.default.disable_ipv6 1",
      "set net.ipv6.conf.lo.disable_ipv6 1",
      "set kernel.sysrq 1",
      "set net.ipv4.tcp_tw_reuse 1",
      "set net.ipv4.tcp_tw_recycle 1",
      "set net.ipv4.ip_local_port_range '1024 65535'",
      "set net.core.somaxconn 1024",
      "set fs.file-max 655350",
    ]
  }

  exec { 'sysctl':
    path => '/sbin',
    command => 'sysctl -p',
    refreshonly => true,
    subscribe => Augeas["sysctl.conf"]
  }

  # 增加文件描述符限制
  # https://puppet.com/docs/puppet/5.5/resources_augeas.html#etcsecuritylimitsconf
  limits::conf {
    'root-soft':
      domain => root,
      type => soft,
      item => nofile,
      value => 65535;
    'root-hard':
      domain => root,
      type => hard,
      item => nofile,
      value =>  65535;
    '*-soft':
      domain => '*',
      type => soft,
      item => nofile,
      value =>  65535;
    '*-hard':
      domain => '*',
      type => hard,
      item => nofile,
      value =>  65535;
  }

  # 增加文件描述符限制
  file { '/etc/systemd/system.conf':
    ensure => file,
    source  => 'puppet:///modules/base/system.conf',
  }
}
