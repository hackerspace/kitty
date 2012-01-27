class common_packages {
  $common_packages = [
    "epel-release",
    "yum-autoupdate",
    "vim-enhanced",
    "wget",
    "strace",
    "ltrace",
    "screen",
    "git",
    "mutt",
    "mailx",
    "gdb",
    "gcc",
    "gcc-c++",
    "autoconf",
    "automake",
    "nc",
    "fpaste",
    ]
  package { $common_packages:
    ensure => installed,
  }
}
