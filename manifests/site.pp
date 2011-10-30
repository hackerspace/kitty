import "ntp.pp"
import "common_packages.pp"

node default {
  include motd
  include common_packages
  include ntp
}
