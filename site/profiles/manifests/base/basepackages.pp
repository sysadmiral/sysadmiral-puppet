class profiles::base::basepackages {

  #packages that are installed via a puppet module
  class { '::ntp': }

  #packages installed via installer
  class stuffWeWant {
    $pkgs = [ 'sudo' ]
    Package { ensure => 'installed' }
    package { $pkgs: }
  }

  #packages removed via installer
  class stuffWeDontWant {
    $pkgs = []
    Package { ensure => 'absent' }
    package { $pkgs: }
  }

}
