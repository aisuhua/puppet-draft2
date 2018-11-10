# @summary 对服务器节点进行分组
# @link https://www.reddit.com/r/Puppet/comments/4m1ny6/best_ways_to_define_workgroupsroles_with_puppet/
#
class roles {

  $myhost = $::facts['hostname']
  # Grab all role assignments from hiera
  $data = lookup('roles')
  # Filter out the key/value pair that contains the hostname in the value (assuming only one result)
  $rolematch = filter($data) |$items| { "${myhost}" in $items[1] }
  # result would be the pair testwebsvr: "web01 web02"
  # We use the keys function to grab the key name of our matching pair, since that is the role we want
  $rolename = keys($rolematch)[0]

  # Drop a file into the custom facts folder, with 'customrole=testwebsvr'
  file { "/opt/puppetlabs/facter/facts.d/customrole.txt":
    ensure => present,
    mode => '0644',
    content => "customrole=${rolename}",
  }
}