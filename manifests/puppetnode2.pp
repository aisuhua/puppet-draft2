node 'puppetnode2.aisuhua.net' {
  include base
  include php72
  include nginx
  include nginx::default
}