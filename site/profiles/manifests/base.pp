class profiles::base {

  if $facts['osfamily'] == 'Redhat' {
    class { '::epel':
      stage => 'pre'
    }
  }

  class { 'users::teams::webops': }
  class { 'profiles::base::basepackages': }

}
