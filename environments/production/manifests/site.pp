# node 'puppetnode2.aisuhua.net' {
node /^\w+node[1-3]\.aisuhua\.net$/ { # puppetnode.1.aisuhua.net

  include roles

  # notify { 'test2':
  #   message => "$hostname, $fqdn, $customrole, suhua"
  # }

  include config
  include polipo
}