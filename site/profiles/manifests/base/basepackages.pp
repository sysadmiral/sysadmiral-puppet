class profiles::base::basepackages {

  #packages that are installed via a puppet module
  class { '::ntp': }

  #packages installed via installer
  $desiredpkgs = [ 'sudo' ]
  package { $pkgs: }
  
  #packages removed via installer
  $undesiredpkgs = []
  package { $undesiredpkgs: ensure => 'absent' }

}
