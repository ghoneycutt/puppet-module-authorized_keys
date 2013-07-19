# == Class: authorized_keys
#
# Adds or deletes one or more ssh-keys
#
class ssh (
  $authorized_keys = undef,
) {

  if $authorized_keys != undef {
    create_resources('ssh::authorized_key',$authorized_keys)
  }
}

define ssh::authorized_key (
  $key,
  $path,
  $type = 'ssh-rsa',
) {

  include concat::setup
  
  concat { $path:
    owner => root,
    group => root,
    mode  => '0600',
  }
  
  concat::fragment { "header":
    target  => $path,
    content => "# This file is being maintained by Puppet.\n# DO NOT EDIT\n",
    order   => 1,
  }

  concat::fragment { $name:
    target  => $path,
    content => "${type} ${key} ${name}\n",
  }
}
