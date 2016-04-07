class profiles::personalcomputer::personalcomputerpackages {

  #packages that are installed via a puppet module

  #packages installed via installer
  class stuffWeWant {
    $pkgs = [ 'pwgen', 'dos2unix' ]
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
