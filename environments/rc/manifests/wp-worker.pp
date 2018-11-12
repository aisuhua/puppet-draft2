# 内网 worker 机器
# worker1.dev.aisuhua.net
# worker2.dev.aisuhua.net
#
node /^worker\d+\.dev\.\d+\.\d+\.\d+\.\d+\.hn1\.aisuhua\.net$/ {
  include roles
  include base
  include rsync
  include php72
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