class profiles::personalcomputer {

  include stdlib
  class { 'profiles::personalcomputer::personalcomputerrepos': }
  class { 'profiles::personalcomputer::personalcomputerpackages': }

}
