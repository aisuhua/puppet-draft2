class php72 {

  apt::ppa { 'ppa:ondrej/php': }

  exec { "updateondrejphp":
    path => '/usr/bin:/bin',
    command => "apt-get update",
    subscribe => [Apt::Ppa['ppa:ondrej/php']],
    refreshonly => true
  }
}