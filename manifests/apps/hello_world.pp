class hello_world_instance {

  webapp::python::instance { "hello_world":
    ensure => present,
    domain => "hello.base48.cz",
    wsgi_module => "debug:hello_world",
    projectroot => "/var/web/env/hello_world/",
    require => [User["web"], Package["supervisor"]],
  }
}
