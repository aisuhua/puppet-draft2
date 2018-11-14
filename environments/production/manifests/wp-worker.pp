# wp worker 机器
# wp-worker1.192.168.1.150.hn1.aisuhua.net
# wp-worker2.192.168.1.151.hn1.aisuhua.net
#
node /^wp-worker\d+\.\d+\.\d+\.\d+\.\d+\.hn1\.aisuhua\.net$/ {
  include roles
  include base
  include rsync
  include php72
  include php72::config
  include php72::yar
  include php72::phalcon
  include php72::gearman
  include php72::couchbase
  include php72::xdebug
  include supervisor
  include supervisor::foo
  include logrotate
  include logrotate::foo
}