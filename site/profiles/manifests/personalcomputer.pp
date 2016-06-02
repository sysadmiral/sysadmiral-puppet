class profiles::personalcomputer {

  class { 'profiles::personalcomputer::personalcomputerrepos': }
  class { 'profiles::personalcomputer::personalcomputerpackages': }

}
