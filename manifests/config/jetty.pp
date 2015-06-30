# Class: activemq::config::jetty
#
class activemq::config::jetty (
  $admin_authentication = true,
  $user_authentication = true,
  $file,
){
  $admin_list = 'beans/bean[ #attribute/id = "adminSecurityConstraint" ]/property[ #attribute/name = "authenticate" ]/#attribute/value'
  $user_list = 'beans/bean[ #attribute/id = "securityConstraint" ]/property[ #attribute/name = "authenticate" ]/#attribute/value'

  augeas { 'activemq/jetty/admin_access':
    incl    => $file,
    lens    => 'Xml.lns',
    changes => [
      "set ${admin_list} ${admin_authentication}",
    ],
    notify  => Service['activemq'],
  }

  augeas { 'activemq/jetty/user_access':
    incl    => $file,
    lens    => 'Xml.lns',
    changes => [
      "set ${user_list} ${user_authentication}",
    ],
    notify  => Service['activemq'],
  }
}
