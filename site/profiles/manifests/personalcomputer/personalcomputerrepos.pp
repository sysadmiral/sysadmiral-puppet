# This class will add desired repos as well as pulling in puppet modules that
# install repos e.g. perconarepo

class profiles::personalcomputer::personalcomputerrepos {
  if $facts['osfamily'] == 'Redhat' {
    class { '::perconarepo':
      stage                           => 'setup',
      perconareleasebasearch_enabled  => '0',
      perconareleasenoarch_enabled    => '0',
      perconareleasesource_enabled    => '0'
    }
  }
}
