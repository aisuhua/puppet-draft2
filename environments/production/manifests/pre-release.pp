# 灰度机器
# pre-release1.192.168.1.200.hn1.aisuhua.net
# pre-release2.192.168.1.201.hn1.aisuhua.net
# pre-release-worker1.192.168.1.210.hn1.aisuhua.net
#
node /^pre-release\d+\.\d+\.\d+\.\d+\.\d+\.hn1\.aisuhua\.net$/ {
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
  include nginx
  include nginx::config
  include nginx::foo
  include nginx::demo
  include logrotate
  include logrotate::foo
}