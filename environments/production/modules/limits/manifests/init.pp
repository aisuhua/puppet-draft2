class limits {

  # https://puppet.com/docs/puppet/5.5/resources_augeas.html#etcsecuritylimitsconf
  limits::conf {
    'root-soft':
      domain => root,
      type => soft,
      item => nofile,
      value => 65535;
    'root-hard':
      domain => root,
      type => hard,
      item => nofile,
      value =>  65535;
    '*-soft':
      domain => '*',
      type => soft,
      item => nofile,
      value =>  65535;
    '*-hard':
      domain => '*',
      type => hard,
      item => nofile,
      value =>  65535;
  }
}