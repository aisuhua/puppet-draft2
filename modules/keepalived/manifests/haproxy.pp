# @summary Keepalived 保持 Nginx 高可用示例
# @link http://blog.51cto.com/nmshuishui/1405486
#
class keepalived::haproxy {

  package { 'keepalived':
    ensure => installed
  }

  file { '/etc/keepalived/keepalived.conf':
    ensure => present,
    source => "puppet:///modules/keepalived/haproxy/${fqdn}.conf",
    notify => Service['keepalived']
  }

  service { 'keepalived':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus=> true
  }
}