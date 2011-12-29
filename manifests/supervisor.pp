package { "supervisor":
  ensure => installed,
  require => Yumrepo["supervisor"]
}
