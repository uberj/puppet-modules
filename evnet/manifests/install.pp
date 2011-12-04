# Parameters
# basedir = where to keep the evnet library files.

class evnet::install ( $basedir = "opt" ){

		package { "git":
			ensure => present,
			before => Git::Clone['evnet'],
		}

		package { "python-openssl":
			ensure => present,
			before => Exec["evnet install"],
		}

		package { "python-dev":
			ensure => present,
			before => Exec["evnet install"],
		}

		file { "/${basedir}/evnet/":
			ensure => directory,
			mode => 0640,
			owner => root,
            group => root,
		}

		git::clone { "evnet":

			source => "https://github.com/rep/evnet.git",
			localtree => "/${basedir}",
		}

		Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin" }

		exec { "evnet install":
			cwd => "/${basedir}/evnet/",
			unless => "python -c 'import evnet'",
			command => "python setup.py build && python setup.py install",
			require => Git::Clone["evnet"],
		}
}
