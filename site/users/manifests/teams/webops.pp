class users::teams::webops {

  accounts::group { 'webops':
    gid => '20000',
  }

  include users::amo

}
