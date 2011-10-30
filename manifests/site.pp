include "ntp.pp"
include "common_packages.pp"

node default {
  include motd
  include common_packages
  include ntp
}
