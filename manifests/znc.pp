class znc {
  package { "znc", "znc-extra", "znc-infobot":
    ensure => installed
  }
  user { "znc":
    ensure => "present"
  }
  supervisor::service { "znc":
    enable => true,
    command => '/usr/bin/znc'
    user => 'znc',
    require => Package['znc'], Package['supervisor'],
      User['znc'],
}
