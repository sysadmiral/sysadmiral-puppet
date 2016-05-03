class profiles::personalcomputer::personalcomputerpackages {

  #packages that are installed via a puppet module
  class {'virtualbox':
    manage_ext_repo => false
  }

  #packages installed via installer
  $desiredpkgs = [
    'at',
    'cinnamon',
    'clusterssh',
    'curl',
    'dos2unix',
    'git',
    'lightdm',
    'mlocate',
    'nmap',
    'pwgen',
    'subversion',
    'tree',
    'wget',
    'whois'
  ]
  package { $desiredpkgs: ensure => 'latest' }

  if $facts['osfamily'] == 'Redhat' {
    $ospackages = [ 'yum-utils' ]
    package { $ospackages: ensure => 'latest' }
  }
  elsif $facts['osfamily'] ==  'Debian' {
    $ospackages = [ 'apt-file' ]
    package { $ospackages: ensure => 'latest' }
  }

  #packages removed via installer
  $undesiredpkgs = []
  package { $undesiredpkgs: ensure => 'absent' }

}
