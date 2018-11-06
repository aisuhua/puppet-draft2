class sourcelist {

  # https://forge.puppet.com/puppetlabs/apt
  class { 'apt':
    purge => {
      'sources.list' => true
    }
  }

  # 使用中科大镜像
  # https://mirrors.ustc.edu.cn/repogen/
  # https://forge.puppet.com/puppetlabs/apt#replace-the-default-sourceslist-file
  $lsbdistcodename = 'xenial';

  apt::source { "mirrors.ustc.edu.cn-${lsbdistcodename}":
    location => 'https://mirrors.ustc.edu.cn/ubuntu',
    repos => 'main universe multiverse restricted',
  }

  apt::source { "mirrors.ustc.edu.cn-${lsbdistcodename}-security":
    location => 'https://mirrors.ustc.edu.cn/ubuntu',
    repos => 'main universe multiverse restricted',
    release => "${lsbdistcodename}-security"
  }

  apt::source { "mirrors.ustc.edu.cn-${lsbdistcodename}-updates":
    location => 'https://mirrors.ustc.edu.cn/ubuntu',
    repos => 'main universe multiverse restricted',
    release => "${lsbdistcodename}-updates"
  }

  apt::source { "mirrors.ustc.edu.cn-${lsbdistcodename}-backports":
    location => 'https://mirrors.ustc.edu.cn/ubuntu',
    repos => 'main universe multiverse restricted',
    release => "${lsbdistcodename}-backports"
  }
}