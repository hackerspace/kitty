class common_packages {
  $common_packages = ["vim-enhanced", "wget", "strace", "ltrace", "screen", "git", "mutt", "mailx" ]
  package { $common_packages:
    ensure => installed,
  }
}
