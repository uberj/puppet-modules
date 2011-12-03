# I'm pretty much modeling what this guy did: http://lzone.de/node/4

class php_apd::install ( $php_ini = "/etc/php5/cli/php.ini", $trace_dir = "/tmp/apd_traces" ) {

		Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin" }

		package {'php5':
			ensure => present,
			before => [Package['apd'],Exec['zend_extensions'],Exec['apd enable'],Exec['tracedir']],
		}

		package {'apd':
			ensure => present,
			provider => dpkg,
#source => "puppet://puppet/php_apd/files/apd_1.0.1_i386.deb",
			source => "/etc/puppet/modules/php_apd/files/apd_1.0.1_i386.deb",
		}
#zend_extension=/usr/lib/php5/20090626+lfs/apd.so
#apd.statement=1
#apd.tracedir=/tmp/apd-traces
		exec { 'zend_extensions':
			unless => "grep zend_extension=/usr/lib/php5/20090626+lfs/apd.so ${php_ini}",
			command => "echo 'zend_extension=/usr/lib/php5/20090626+lfs/apd.so' >> ${php_ini}",
		}
		exec { 'apd enable':
			unless => "grep apd.statement=1 ${php_ini}",
			command => "echo 'apd.statement=1' >> ${php_ini}",
		}
		exec { 'tracedir':
			unless => "grep apd.tracedir=${trace_dir} ${php_ini}",
			command => "echo 'apd.tracedir=${trace_dir}' >> ${php_ini}",
		}
}
