# Class: motd
#
# This module manages the /etc/motd file using a template
#
# Sample Usage:
#  include motd
class motd {
  file { '/etc/motd':
    ensure  => file,
    content => template("motd/motd.erb"),
  }
}
