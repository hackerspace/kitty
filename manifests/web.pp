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

webapp::python::instance { "test":
  domain => "localhost",
  wsgi_module => "myapp:app",
  requirements => true,
  mediaprefix => "/media",
  mediaroot => "/var/web/env/test/project/media/",
  require => User["web"], Package["supervisor"],
}
