class users::teams::webops {
  include users::amo
  }

  accounts::group { 'webops':
    gid => '20000',
  }
}
