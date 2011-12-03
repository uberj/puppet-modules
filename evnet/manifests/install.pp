# Parameters
# basedir = where to keep the evnet library files.

class evnet::install ( $basedir = "opt" ){
		
		package { "python-openssl":
			ensure => present,
			before => Exec["evnet install"],
		}
			
		file { "/${basedir}/evnet/":
			ensure => directory,
			mode => 0640,
			owner => glaspot,
			require => User["glaspot"],
		}

		git::clone { "evnet":
			source => "https://github.com/rep/evnet.git",
			localtree => "/${basedir}",
			require => User["glaspot"],
		}
		
		Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin" }

		exec { "evnet install":
			cwd => "/${basedir}/evnet/",
			unless => "python -c 'import evnet'",
			command => "python setup.py build && python setup.py install",
			require => Git::Clone["evnet"],
		}
}
