class znc {
  package { "znc":
    ensure => installed
  }
  package { "znc-extra":
    ensure => installed
  }
  package { "znc-infobot":
    ensure => installed
  }
  user { "znc":
    ensure => "present"
  }
  supervisor::service { "znc":
    ensure => present,
    command => '/usr/bin/znc',
    user => 'znc',
    require => [Package['znc'], Package['supervisor'],
      User['znc']],
  }
}
