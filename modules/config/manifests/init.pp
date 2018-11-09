# @sumarry 全局配置
# @see https://stackoverflow.com/questions/37070456/puppet-architecture-for-multiple-environments-of-multiple-applications

class config {

  # resolver
  $nameservers = [
    '192.168.1.46',
    '223.5.5.5',
    '223.6.6.6'
  ]

  # poliop
  $parent_proxy = '192.168.1.229:1080'

  # IDC
  $idc_name = 'HN1'
  $idc_content = 'HUANAN1'

  # ssh
  $ssh_port = 25680
  $ssh_permit_root_login = 'yes'
}