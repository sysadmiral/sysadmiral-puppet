class profiles::base {

  if $facts['osfamily'] == 'Redhat' {
    class { '::epel':
      stage => 'pre'
    }
  }

  class { 'users::teams::webops': }
  class { '::ntp': }
  class sudo {
    package { 'sudo':
      ensure => 'installed',
    }
  }

}
