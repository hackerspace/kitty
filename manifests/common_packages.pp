class common_packages {
  $common_packages = [
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
    ]
  package { $common_packages:
    ensure => installed,
  }
}
