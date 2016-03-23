class profiles::personalcomputer {

  #include bash

  package { 'pwgen':
    ensure => 'installed',
  }
}
