stage { "pre": before => Stage["main"] }

hiera_include('classes')
