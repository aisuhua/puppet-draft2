class hosts::company {

  augeas { 'puppetmaster':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.1.87",
      "set 01/canonical puppetmaster.aisuhua.net",
      "set 01/alias[1] puppetmaster",
    ],
    onlyif => "match *[ipaddr = '192.168.1.87'] size == 0"
  }

  augeas { 'puppetnode1':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.1.143",
      "set 01/canonical puppetnode1.aisuhua.net",
      "set 01/alias[1] puppetnode1",
    ],
    onlyif => "match *[ipaddr = '192.168.1.143'] size == 0"
  }

  augeas { 'puppetnode2':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.1.108",
      "set 01/canonical puppetnode2.aisuhua.net",
      "set 01/alias[1] puppetnode2",
    ],
    onlyif => "match *[ipaddr = '192.168.1.108'] size == 0"
  }

  augeas { 'puppetnode3':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.1.168",
      "set 01/canonical puppetnode3.aisuhua.net",
      "set 01/alias[1] puppetnode3",
    ],
    onlyif => "match *[ipaddr = '192.168.1.168'] size == 0"
  }
}