class ntp {
  package { "ntp":
    ensure => installed
  }

  service { "ntpd":
    ensure  => running,
    require => Package["ntp"],
  }
}
