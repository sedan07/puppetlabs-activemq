# Class: activemq::config::jetty
#
class activemq::config::jetty (
  $admin_authentication = true,
  $user_authentication = true,
  $file,
){
  $admin_list = 'beans/bean[ #attribute/id = "adminSecurityConstraint" ]/property[ #attribute/name = "authenticate" ]/#attribute/value'
  $user_list = 'beans/bean[ #attribute/id = "securityConstraint" ]/property[ #attribute/name = "authenticate" ]/#attribute/value'

  $path_exact = "[ username = \"${username}\" and password = \"${password}\" and realm = \"${realm_list}\" ]"
  $path_list = "[ username = \"${username}\" ]"

  augeas { "activemq/jetty/admin_access":
    incl    => $file,
    lens    => 'Xml.lns',
    changes => [
      "set ${admin_list} ${admin_authentication}",
    ],
  }

  augeas { "activemq/jetty/user_access":
    incl    => $file,
    lens    => 'Xml.lns',
    changes => [
      "set ${user_list} ${user_authentication}",
    ],
  }
}
