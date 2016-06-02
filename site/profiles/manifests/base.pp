class profiles::base {

  accounts::user { 'dummy':
    ensure => 'absent',
  }

  include stdlib
  class { 'users::teams::webops': }
  class { 'profiles::base::basepackages': }
  class { 'profiles::base::baserepos': }

}
