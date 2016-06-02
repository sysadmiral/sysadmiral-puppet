class profiles::base::basepackages {

  #packages that are installed via a puppet module
  class { '::ntp': }
  class { '::sudo': }

  #packages installed via installer
  $desiredpkgs = [ mosh ]
  package { $desiredpkgs: }

  #packages removed via installer
  $undesiredpkgs = []
  package { $undesiredpkgs: ensure => 'absent' }

}
