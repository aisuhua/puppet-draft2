node default {
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
  include nginx::foo
  include supervisor
  include supervisor::foo
  include logrotate
  include logrotate::foo
}