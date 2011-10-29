user { "git":
  ensure => "present",
  home => "/var/git",
}

file {
  "/var/git": ensure => directory, owner => git,
  require => User["git"];
  "/var/git/puppet": ensure => directory, owner => git,
  require => [User["git"], File["/var/git"]],
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

exec { "Fix selinux context":
  cwd => "/var/git/puppet",
  command => "/usr/bin/chcon -t ssh_home_t /var/git/.ssh/authorized_keys",
}
