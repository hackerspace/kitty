Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

import "ntp.pp"
import "repos.pp"
import "supervisor.pp"
import "znc.pp"
import "web.pp"
import "common_packages.pp"

node default {
  include motd
  include repos
  include common_packages
  include ntp
  include supervisor
  include znc
  include web
}
