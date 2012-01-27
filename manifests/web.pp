class web_defaults {
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
  }
}
