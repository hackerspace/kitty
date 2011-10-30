class common_packages {
  $common_packages = ["vim-enhanced", "wget", "strace", "ltrace", "screen", "git" ]
  package { $common_packages:
    ensure => installed,
  }
}
