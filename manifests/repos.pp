class repos {
  yumrepo { "supervisor":
    baseurl  => 'http://repos.fedorapeople.org/repos/rmarko/supervisor/epel-6/noarch/',
    descr    => 'supervisord for epel',
    enabled  => 1,
    gpgcheck => 0
  }
}
