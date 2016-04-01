stage { "pre": before => Stage["main"] }

class someguff {
  notify {"This is some stuff in the screen"
    withpath => true,
  }
  stage => "pre",
}

hiera_include('classes')
