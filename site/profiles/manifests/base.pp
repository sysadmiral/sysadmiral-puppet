class profiles::base {
  class { 'users::teams::webops': }
  class { '::ntp': }
  class sudo {
    package { 'sudo':
      ensure => 'installed',
    }
  }

  if $facts['osfamily'] == 'Redhat' {
    class { '::epel':
      stage => 'pre'
    }
  }
}
