class profiles::base {

  include stdlib
  class { 'users::teams::webops': }
  class { 'profiles::base::basepackages': }

}
