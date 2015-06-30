# Class: activemq::config::wrapper
#
#   Modify bin/wrapper.conf
#
define activemq::config::wrapper (
  $property,
  $value,
  $file
) {

  augeas { "activemq/wrapper/${property}":
    changes => [ "set ${property} ${value}" ],
    incl    => $file,
    lens    => 'Properties.lns',
    notify  => Service['activemq'],
    require => Package['activemq'],
  }
}
