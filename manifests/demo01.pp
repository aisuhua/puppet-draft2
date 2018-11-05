node demo01 {

  # augeas { "sshd_config":
  #   changes => "set /files/etc/ssh/sshd_config/PermitRootLogin no"
  # }

  # augeas { "sshd_config":
  #   context => '/files/etc/ssh/sshd_config',
  #   changes => "set PermitRootLogin yes"
  # }

  # 添加域名解析
  # See detail in https://github.com/hercules-team/augeas/wiki/Adding-nodes-to-the-tree
  augeas { "add_aisuhua_com":
    context => '/files/etc/hosts',
    changes => [
      "set 7/ipaddr 192.168.1.3",
      "set 7/canonical www.aisuhua.com",
      "set 7/alias[1] blog.aisuhua.com",
      "set 7/alias[2] note.aisuhua.com",
    ]
  }

  # 修改特定的域名解析
  # augeas { "change_aishua_com":
  #   context => '/files/etc/hosts',
  #   changes => [
  #     "set *[canonical = 'www.aisuhua.com']/canonical www.aisuhua.net",
  #     "set *[canonical = 'www.aisuhua.net']/alias[1] blog.aisuhua.net",
  #     "rm *[canonical = 'www.aisuhua.net']/alias[2]"
  #   ]
  # }

  # 修改用户 sudo 权限
  augeas { "sudo_suhua":
    context => '/files/etc/sudoers',
    changes => [
      "set spec[user = 'suhua']/user suhua",
      "set spec[user = 'suhua']/host_group/host ALL",
      "set spec[user = 'suhua']/host_group/command ALL",
      "set spec[user = 'suhua']/host_group/command/runas_user ALL",
      "set spec[user = 'suhua']/host_group/command/runas_group ALL",
      "set spec[user = 'suhua']/host_group/command/tag NOPASSWD",
    ]
  }
}
