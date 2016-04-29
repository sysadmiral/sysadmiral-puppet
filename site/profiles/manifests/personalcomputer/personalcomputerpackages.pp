class profiles::personalcomputer::personalcomputerpackages {

  #packages that are installed via a puppet module
  class {'virtualbox':
    manage_ext_repo => false
  }

  #packages installed via installer
  $desiredpkgs = [ 'pwgen', 'dos2unix', 'curl', 'git', 'nmap', 'subversion', 'tree', 'wget', 'whois', 'at', 'cinnamon', 'lightdm']
  package { $desiredpkgs: ensure => 'latest' }

  $ospackages = $facts['osfamily'] ? {
    Redhat  => [ 'yum-utils' ],
    Debian  => [ 'apt-file' ],
    default => ''
  }
  package { $ospackages: ensure => 'latest' }

  #packages removed via installer
  $undesiredpkgs = []
  package { $undesiredpkgs: ensure => 'absent' }

}
