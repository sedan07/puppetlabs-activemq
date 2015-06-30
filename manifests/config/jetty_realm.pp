# Define: activemq::config::jetty_realm
#
define activemq::config::jetty_realm (
  $username,
  $password,
  $file,
  $realms = [],
){
  validate_re($username, '^(?=.*[a-zA-Z0-9]$)[a-zA-Z0-9][a-zA-Z0-9_-]*$', 'The Jetty Realm username should only use a-z 0-9 and - and _ chars')

  $realm_list = join($realms, ',')

  $path_exact = "[ username = \"${username}\" and password = \"${password}\" and realm = \"${realm_list}\" ]"
  $path_list = "[ username = \"${username}\" ]"

  augeas { "activemq/jetty-realm/${username}":
    incl    => $file,
    lens    => 'JettyRealm.lns',
    changes => [
      "rm user[*]${path_list}",
      "set user[last()+1]/username ${username}",
      "set user[last()]/password ${password}",
      "set user[last()]/realm ${realm_list}"
    ],
    onlyif  => "match user[*]${path_exact} size == 0",
    notify  => Service['activemq'],
  }
}
