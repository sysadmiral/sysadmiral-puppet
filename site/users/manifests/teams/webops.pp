class users::teams::webops {
  accounts::user { 'amo': 
    uid => '1000',
    gid => '1000',
    groups => [ 'webops'],
  }
  accounts::group { 'webops':
    gid => '20000',
  }
}
