# Class: activemq::packages
#
#   ActiveMQ Packages
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class activemq::packages (
  $version,
  $package,
  $overwrite_initd = true
) {
  $version_real = $version
  $package_real = $package

  if $activemq::local_install == false {
    package { $package_real:
      ensure  => $version_real,
      notify  => Service['activemq'],
    }

    if $::osfamily == 'RedHat' and $overwrite_initd == true {
      # JJM Fix the activemq init script always exiting with status 0
      # FIXME This should be corrected in the upstream packages
      file { '/etc/init.d/activemq':
        ensure  => file,
        path    => '/etc/init.d/activemq',
        content => template("${module_name}/init/activemq"),
        owner   => '0',
        group   => '0',
        mode    => '0755',
      }
    }
  } else {
    # include activemq::local_install
    class { 'activemq::local_install':
      version => $version,
    }
  }
}