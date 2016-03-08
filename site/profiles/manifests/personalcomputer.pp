class profiles::personalcomputer {
  package { 'pwgen':
    ensure => 'installed',
  }
}
