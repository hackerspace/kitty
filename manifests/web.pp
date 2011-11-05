# temporary - only for standalone testing
Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

user { "web":
  ensure => "present",
}

file {
  "/var/web": ensure => directory, owner => web,
  require => User["web"];
  "/var/web/src": ensure => directory, owner => web,
  require => User["web"];
  "/var/web/env": ensure => directory, owner => web,
  require => User["web"];
}

class { "webapp::python": owner => "web",
                          group => "web",
                          src_root => "/var/web/src",
                          venv_root => "/var/web/env",
                          monit_admin => "root@localhost",
}

webapp::python::instance { "test":
  domain => "test.base48.cz",
  django => true,
  requirements => true,
  require => User["web"],
}
