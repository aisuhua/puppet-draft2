node 'puppetnode2.aisuhua.net' {
  include base
  include php72
  include php72::yar
  include php72::phalcon
  include php72::gearman
  include php72::couchbase
  include php72::xdebug
  include nginx
  include nginx::default
}