class profiles::personalcomputer::personalcomputerpackages {

  #packages that are installed via a puppet module
  class {'virtualbox':
    manage_ext_repo => false
  }

  class {'docker': 
    docker_users => [ 'amo' ],
    create_user  => false
  }

  #packages installed via installer
  $desiredpkgs = [
    'at',
    'alsa-utils',
    'cinnamon',
    'clusterssh',
    'curl',
    $dconf = $facts['osfamily'] ? {
      'Debian' => 'dconf-cli',
      'Redhat' => 'dconf'
      default  => undef
    },
    'dos2unix',
    'git',
    'gnome-terminal',
    'jq',
    'lightdm',
    'meld',
    'mlocate',
    'nmap',
    $packageproviderutils = $facts['osfamily'] ? {
      'Debian' => 'apt-file',
      'Redhat' => 'yum-utils',
      default  => undef
    },
    'pwgen',
    'subversion',
    'tree',
    'wget',
    'whois'
  ]
  package { $desiredpkgs: ensure => 'latest' }

  #packages removed via installer
  $undesiredpkgs = []
  package { $undesiredpkgs: ensure => 'absent' }

}
