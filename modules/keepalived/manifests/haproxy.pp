# @summary Keepalived 保持 haproxy 主主负载均衡高可用示例
# @link http://blog.51cto.com/nmshuishui/1405486
#
class keepalived::haproxy {
  
  file { '/etc/keepalived/keepalived.conf':
    ensure => present,
    source => "puppet:///modules/keepalived/haproxy/${fqdn}.conf",
    notify => Exec['keepalived-reload']
  }
}