# Define: activemq::config::jetty_realm
#
define activemq::config::jetty_realm (
  $username,
  $password,
  $realm,
  $file
){
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
