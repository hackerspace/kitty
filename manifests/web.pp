include webapp::python

webapp::python::instance { "test":
  domain => "test.base48.cz",
  django => true,
  requirements => true,
}
