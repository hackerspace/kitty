class repos {
  yumrepo { "supervisor":
    baseurl  => 'http://repos.fedorapeople.org/repos/rmarko/supervisor/epel-$releasever/$basearch/',
    descr    => 'supervisord for epel',
    enabled  => 1,
    gpgcheck => 0
  }
}
