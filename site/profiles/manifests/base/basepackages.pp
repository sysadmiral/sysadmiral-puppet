class profiles::base::basepackages {

  #packages that are installed via a puppet module
  if $facts['osfamily'] == 'Redhat' {
    class { '::epel': stage => 'setup' }
    class { '::perconarepo': stage => 'setup' }
  }
  
  class { '::ntp': }
  class { '::sudo': }
  
  #packages installed via installer
  $desiredpkgs = [ mosh ]
  package { $desiredpkgs: }
  
  #packages removed via installer
  $undesiredpkgs = []
  package { $undesiredpkgs: ensure => 'absent' }

}
