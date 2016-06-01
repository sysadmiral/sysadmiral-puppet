#!/usr/bin/env bash

###
# Shell script for bootstrapping a new laptop
###

set -e

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
  echo "caught CTRL-C - EXITING!"
  exit 1
}

lockfile=/var/lock/sysadmiral.lock
bootstrap_file=/root/.sysadmiral.bootstrap
my_puppet_conf_location="https://raw.githubusercontent.com/sysadmiral/sysadmiral-puppet-control/production/bootstrap/puppet.conf"
my_r10k_yaml_location="https://raw.githubusercontent.com/sysadmiral/sysadmiral-puppet-control/production/bootstrap/r10k.yaml"
pre_req_pkgs="ca-certificates git"
internet_check_URL="www.google.com" # make this changeable just in case google goes down!

del_lockfile ()
{
  if [[ -f ${lockfile} ]]; then
    rm -f ${lockfile}
  fi
}

cleanup ()
{
  del_lockfile
  exit 1
}

there_can_be_only_one ()
{
  if [[ -f ${lockfile} ]]; then
    echo "Cannot run more than one instance"
    exit 1
  else
    touch ${lockfile}
  fi
}

are_we_root ()
{
  if [[ ${EUID} != "0" ]]; then
    echo "This script must be run as root" 1>&2;
    cleanup
  fi
}

are_we_bootstrapped ()
{
  if [[ -f ${bootstrap_file} ]]; then
    echo "This machine has already been bootstrapped the sysadmiral way. Exiting.";
    cleanup
  fi
}

get_vars ()
{
  if [[ -f /etc/os-release ]]; then
    my_os_type=$(sed -n -e 's/^ID=//p' /etc/os-release | sed -e 's/\"//g')
  elif [[ -f  /etc/centos-release ]]; then
    my_os_type=centos
  elif [[ -f /etc/debian_version ]]; then
    my_os_type=debian
  else
    echo "Unable to determine OS. This script has been tested with debian jessie and centos 7 only."
    cleanup
  fi

  case $my_os_type in
    debian)
      installer=$(which apt-get)
      installer_opts="install -qq"
      pkg_installer=$(which dpkg)
      pkg_installer_opts="-i"
      puppet_repo="https://apt.puppetlabs.com/"
      puppet_repo_pkg="puppetlabs-release-pc1-jessie.deb"
      fetcher=$(which wget)
      fetcher_opts="-O -"
      fetcher_internet_check_opts="-q --spider"
      pre_req_pkgs="${pre_req_pkgs} lsb-release"
      ;;
    centos)
      installer=$(which yum)
      installer_opts="install -q -y"
      pkg_installer=${installer}
      pkg_installer_opts="install -y"
      puppet_repo="https://yum.puppetlabs.com/"
      puppet_repo_pkg="puppetlabs-release-pc1-el-7.noarch.rpm"
      fetcher=$(which curl)
      fetcher_opts=""
      fetcher_internet_check_opts="--silent --head"
      pre_req_pkgs="${pre_req_pkgs} redhat-lsb"
      ;;
    *)
      echo "my_os_type not found"
      cleanup
      ;;
  esac
}

internet_check ()
{
  internet_check_command="${fetcher} ${fetcher_internet_check_opts} ${internet_check_URL}"
  echo "Checking we are online..."
  ${internet_check_command} 1> /dev/null
  if [ $? == 0 ]; then
    echo "We are online! \o/";
  else
    echo "Get some internet all up in here!";
    cleanup
  fi
}

install_pre_reqs ()
{
  echo "Installing required packages. Please wait..."
  ${installer} ${installer_opts} ${pre_req_pkgs}
  if [[ $my_os_type == "centos" ]]; then
    ${installer} -q -y groupinstall "X Window system"
  fi
  echo "Required packages installed"
}

get_env ()
{
  echo;
  echo "What Puppet environment will this machine use?"
  read puppet_env
  echo;
}

install_puppet ()
{
  echo "Installing puppet repo and puppet-agent"
  ${fetcher} ${fetcher_opts} ${puppet_repo}${puppet_repo_pkg} > /tmp/${puppet_repo_pkg}
  ${pkg_installer} ${pkg_installer_opts} /tmp/${puppet_repo_pkg}
  ${installer} update -y && ${installer} install -y puppet-agent
  ${fetcher} ${fetcher_opts} ${my_puppet_conf_location} > /etc/puppetlabs/puppet/puppet.conf
  echo "puppet-agent is installed"
  puppet_bin_dir="/opt/puppetlabs/puppet/bin/"
}

install_R10K ()
{
  echo "Installing r10k"
  ${puppet_bin_dir}gem install --no-rdoc --no-ri r10k
  mkdir /etc/puppetlabs/r10k
  ${fetcher} ${fetcher_opts} ${my_r10k_yaml_location} > /etc/puppetlabs/r10k/r10k.yaml
  echo "r10k installed and config file created"
}

post_install() {
  if [[ $my_os_type == "centos" ]]; then
    systemctl set-default graphical.target
    rm -f /etc/systemd/system/default.target
    ln -s '/usr/lib/systemd/system/graphical.target' '/etc/systemd/system/default.target'
  fi
}

bootstrap ()
{
  ${puppet_bin_dir}r10k deploy environment ${puppet_env} -v --puppetfile
  ${puppet_bin_dir}puppet apply --verbose --hiera_config=/etc/puppetlabs/code/environments/${puppet_env}/hiera.yaml /etc/puppetlabs/code/environments/${puppet_env}/site.pp
}

youve_been_bootstrapped ()
{
  echo "This file stops the sysadmiral bootstrap from being run more times than the initial run which may have undesirable effects" > ${bootstrap_file};
}

there_can_be_only_one
are_we_root
are_we_bootstrapped
get_vars
internet_check
install_pre_reqs
get_env
install_puppet
install_R10K
post_install
bootstrap
youve_been_bootstrapped
