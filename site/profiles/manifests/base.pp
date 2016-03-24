class profiles::base {
  class { 'users::teams::webops': }
  class { '::ntp': }
}
