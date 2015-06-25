# Define: activemq::config::jetty_realm
#
define activemq::config::jetty_realm (
  $username,
  $password,
  $realm,
  $file
){
  validate_re($username, '^(?=.*[a-zA-Z0-9]$)[a-zA-Z0-9][a-zA-Z0-9_-]*$', 'The Jetty Realm username should only use a-z 0-9 and - and _ chars')

  augeas { "activemq_jetty_realm_${username}":
    incl    => $file,
    lens    => 'JettyRealm.lns',
    changes => [
      "set user[last()]/username ${username}",
      "set user[last()]/password ${password}",
      "set user[last()]/realm ${realm}"
    ],
  }
}
