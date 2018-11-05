class ntpdate {

  package {
    'ntp':
      ensure => absent;
    'ntpdate':
      ensure => installed;
  }

  cron {
    'ntpdate_sync1':
      command => '/usr/sbin/ntpdate ntp7.aliyun.com',
      user    => root,
      minute  => '1',
      hour    => '6';
    'ntpdate_sync2':
      command => '/usr/sbin/ntpdate ntp6.aliyun.com',
      user    => root,
      minute  => '1',
      hour    => '18';
  }
}
