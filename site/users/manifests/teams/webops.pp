class users::teams::webops {
  accounts::user { 'amo': 
    uid => '1000',
    gid => '1000',
    groups => [ 'webops'],
    sshkeys  => [ 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+fehaNU2RvKDegsbX5PUxv1mMpV0C/iwmXN4Jpeg33wlTQJbqitx32WSNzJ0VcmySMCMH4k0cX8nxb5Ozx3UNWc3FqMxlVVEVmGZun9C4jzxxTfWhIZpFWk+1b0v3Wu4t2L8IEq10469QosjHgUqS7DGlNAn/n+alBgXXNve5NeRCaXFf9QQaHM6ccYDRdKipm/XwwbqUcL2T+R5UrHbvwPuJ+jXfnRhQM4b7OC+V4/L8z7/P93XqPYvJwTj5Kn4tJigxww560fdTRGg8JPrWRWhbyXwu7m3+Emr77CXS1TIEIG5Ssry0+QY8KOm4nQjhp6SEMzaRZx1xqw3tNR1t amo.chumber@connect-group.com' ],
    password => "$6$l530cybVGX$fIfATux9OuSJ4ZkwDSC5GdWOnJ31CFiTDiz/lAWsxosZ2VMWc9tCtfyv5.V4SCDwUYPHoGgHi0PyJ4WPw42hy.",
    comment  => 'Amo Chumber',
  }
  accounts::group { 'webops':
    gid => '20000',
  }
}
