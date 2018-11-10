class polipo::example {

  exec { 'example':
    environment => [
      "http_proxy=http://127.0.0.1:8123",
      "https_proxy=http://127.0.0.1:8123"
    ],
    path => '/bin:/usr/bin',
    command => 'curl ifconfig.io > /tmp/start_proxy && curl cip.cc >> /tmp/start_proxy curl google.com >> /tmp/start_proxy'
  }
}