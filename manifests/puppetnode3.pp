node 'puppetnode3.aisuhua.net' {
  include base
  include php72
  include php72::yar
  include php72::phalcon
}