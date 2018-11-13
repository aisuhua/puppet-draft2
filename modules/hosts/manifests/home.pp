class hosts::home {

  augeas { 'puppetmaster':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.220",
      "set 01/canonical puppetmaster.aisuhua.net",
      "set 01/alias[1] puppetmaster",
    ],
    onlyif => "match *[ipaddr = '192.168.31.220'] size == 0"
  }

  augeas { 'wp-web1':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.221",
      "set 01/canonical wp-web1.192.168.1.100.hn1.aisuhua.net",
      "set 01/alias[1] wp-web1",
    ],
    onlyif => "match *[ipaddr = '192.168.31.221'] size == 0"
  }

  augeas { 'wp-web2':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.222",
      "set 01/canonical wp-web2.192.168.1.101.hn1.aisuhua.net",
      "set 01/alias[1] wp-web2",
    ],
    onlyif => "match *[ipaddr = '192.168.31.222'] size == 0"
  }

  augeas { 'pre-release1':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.223",
      "set 01/canonical pre-release1.192.168.1.200.hn1.aisuhua.net",
      "set 01/alias[1] pre-release1",
    ],
    onlyif => "match *[ipaddr = '192.168.31.223'] size == 0"
  }

  augeas { 'pre-release2':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.224",
      "set 01/canonical pre-release1.192.168.1.200.hn1.aisuhua.net",
      "set 01/alias[1] pre-release1",
    ],
    onlyif => "match *[ipaddr = '192.168.31.224'] size == 0"
  }
}