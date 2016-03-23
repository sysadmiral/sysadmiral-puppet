class profiles::base {
  class { '::accounts::teams::webops': }
  class { '::ntp': }
}
