# Class: activemq::config::credentials
#
class activemq::config::credentials (
  $activemq_username = 'system',
  $activemq_password = 'manager',
  $guest_password    = 'password',
  $file,
){
  $activemq_username_list = 'activemq.username'
  $activemq_password_list = 'activemq.password'
  $guest_password_list = 'guest.password'

  augeas { 'activemq/credentials':
    incl    => $file,
    lens    => 'Properties.lns',
    changes => [
      "set ${activemq_username_list} ${activemq_username}",
      "set ${activemq_password_list} ${activemq_password}",
      "set ${guest_password_list} ${guest_password}",
    ],
    notify  => Service['activemq'],
    require => Package['activemq'],
  }

}
