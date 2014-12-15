# Class: activemq::service
#
#   Manage the ActiveMQ Service
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class activemq::service(
  $ensure
) {

  # Arrays cannot take anonymous arrays in Puppet 2.6.8
  $v_ensure = [ '^running$', '^stopped$' ]
  validate_re($ensure, $v_ensure)

  $ensure_real = $ensure

  $start_on_boot =  $ensure_real ? {
    'running' => true,
    default   => false
  }

  service { 'activemq':
    ensure     => $ensure_real,
    enable     => $start_on_boot,
    hasstatus  => true,
    hasrestart => true,
    require    => Class['activemq::packages'],
  }

}
