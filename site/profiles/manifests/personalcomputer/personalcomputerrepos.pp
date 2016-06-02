# This class will add desired repos as well as pulling in puppet modules that
# install repos e.g. perconarepo

class profiles::personalcomputer::personalcomputerrepos {
  if $facts['osfamily'] == 'Redhat' {
    class { '::perconarepo': stage => 'setup' }
  }
}
