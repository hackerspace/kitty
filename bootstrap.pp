user { "git":
  ensure => "present",
  home => "/var/git",
}

file {
  "/var/git": ensure => directory, owner => git,
    require => User["git"];
  "/var/git/puppet": ensure => directory, owner => git,
    require => [User["git"], File["/var/git"]];
  "/etc/puppet": ensure => directory, owner => root;
  "/etc/puppet/conf/": ensure => directory, owner => root,
    require => File["/etc/puppet"];
  "/etc/puppet/auth.conf": ensure => absent;
}

ssh_authorized_key { "git":
  ensure => present,
  key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDbKzxQep8pWdIRoDCEbZKD+owMoUonA2K7yKugAoHmKLeqOMNMcIAYdzaxhFYCoyTyUKJnOzKchTlBL4o5zYTUpf7VD9pya6OGt4n5z7UhJKZJIzeso03fHyFDRo3tI3vYVEM7OvLbBufkt8gBQiPf1OhNveRoIhWDjcT+/F/eImyU3pA/7tnhWN6uJONiNxsUGgrpBkM5dGNwT8wUL4OSL778yzAKzTYb35XHLRa2f6OzSebGuJVBiSLPIXoHKIbcjIJlvwlj64UuIBGoiBZnr43RWTYJ9urHhT8eVPQXN65GXbOHZcOL5QMNBG4WZH3TCUKNfxdkyeBRXLUAcF95",
  target => "/var/git/.ssh/authorized_keys",
  name => "git@kitty",
  user => "git",
  type => rsa,
  require => File["/var/git"],
}

package { "git":
  ensure => installed,
}

exec { "Create puppet Git repo":
  cwd => "/var/git/puppet",
  user => "git",
  command => "/usr/bin/git init --bare",
  creates => "/var/git/puppet/HEAD",
  require => [File["/var/git/puppet"], Package["git"], User["git"]],
}

exec { "Clone nonbare version of repo":
  cwd => "/etc/puppet/conf",
  command => "/usr/bin/git clone /var/git/puppet .",
  creates => "/etc/puppet/conf/.git/HEAD",
  require => [File["/etc/puppet/conf"],
    Package["git"], User["git"], Exec["Create puppet Git repo"]],
}

exec { "Fix selinux context":
  cwd => "/var/git/puppet",
  command => "/usr/bin/chcon -t ssh_home_t /var/git/.ssh/authorized_keys",
}

$update = "#!/bin/bash
cd /etc/puppet/conf
git pull origin &> /var/log/puppet-pull || exit 0
git submodule update --init &> /var/log/puppet-update
/usr/bin/puppet -l syslog /etc/puppet/conf/manifests/site.pp
"

$script_path = "/usr/local/bin/puppet-update"

file { $script_path:
  ensure  => present,
  content => $update,
  mode    => 744,
}

$puppetcfg = "[main]
  confdir = /etc/puppet/conf/"

file { "/etc/puppet/puppet.conf":
  ensure => present,
  content => $puppetcfg,
}

cron { "Puppet":
  ensure  => present,
  command => $script_path,
  user    => "root",
  minute  => "*",
  require => File[$script_path, "/etc/puppet/puppet.conf"],
}
