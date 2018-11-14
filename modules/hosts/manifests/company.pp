class hosts::company {

  # puppetmaster
  augeas { 'puppetmaster':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.1.87",
      "set 01/canonical puppetmaster.aisuhua.net",
      "set 01/alias[1] puppetmaster",
    ],
    onlyif => "match *[ipaddr = '192.168.1.87'] size == 0"
  }

  # web 服务
  augeas { 'wp-web1':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.1.143",
      "set 01/canonical wp-web1.192.168.1.100.hn1.aisuhua.net",
      "set 01/alias[1] wp-web1",
    ],
    onlyif => "match *[ipaddr = '192.168.1.143'] size == 0"
  }

  augeas { 'wp-web2':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.1.100",
      "set 01/canonical wp-web2.192.168.1.101.hn1.aisuhua.net",
      "set 01/alias[1] wp-web2",
    ],
    onlyif => "match *[ipaddr = '192.168.1.100'] size == 0"
  }

  # worker
  # augeas { 'wp-worker1':
  #   context => '/files/etc/hosts',
  #   changes => [
  #     "set 01/ipaddr 192.168.1.168",
  #     "set 01/canonical wp-worker1.192.168.1.150.hn1.aisuhua.net",
  #     "set 01/alias[1] wp-worker1",
  #   ],
  #   onlyif => "match *[ipaddr = '192.168.1.168'] size == 0"
  # }

  # IP 发生变化需清理无效条目
  augeas { 'wp-worker1':
    context => '/files/etc/hosts',
    changes => [
      "rm *[canonical = 'wp-worker1.192.168.1.150.hn1.aisuhua.net']",
    ],
    onlyif => "match *[canonical = 'wp-worker1.192.168.1.150.hn1.aisuhua.net'] size == 1"
  }

  augeas { 'clear-wp-web2':
    context => '/files/etc/hosts',
    changes => [
      "rm *[ipaddr = '192.168.1.108']",
    ],
    onlyif => "match *[ipaddr = '192.168.1.108'] size == 1"
  }

  # 内网
  augeas { 'web1':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.1.114",
      "set 01/canonical web1.dev.aisuhua.net",
      "set 01/alias[1] web1",
    ],
    onlyif => "match *[ipaddr = '192.168.1.114'] size == 0"
  }

  # 灰度
  augeas { 'pre-release1':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.1.244",
      "set 01/canonical pre-release1.192.168.1.200.hn1.aisuhua.net",
      "set 01/alias[1] pre-release1",
    ],
    onlyif => "match *[ipaddr = '192.168.1.244'] size == 0"
  }

  augeas { 'pre-release2':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.1.116",
      "set 01/canonical pre-release2.192.168.1.201.hn1.aisuhua.net",
      "set 01/alias[1] pre-release2",
    ],
    onlyif => "match *[ipaddr = '192.168.1.116'] size == 0"
  }

  augeas { 'lb1':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.1.168",
      "set 01/canonical lb1.192.168.1.111.hn1.aisuhua.net",
      "set 01/alias[1] lb1",
    ],
    onlyif => "match *[ipaddr = '192.168.1.168'] size == 0"
  }
}