#
# Let's get this working before we make it pretty.
#

class glaspot::evnet {
		
		package { 'python-openssl':
			ensure => present,
			before => Exec['evnet install'],
		}
			
		file { '/home/glaspot/evnet/':
			ensure => directory,
			mode => 0640,
			owner => glaspot,
			require => User['glaspot'],
		}

		git::clone { "evnet":
			source => "https://github.com/rep/evnet.git",
			localtree => "/home/glaspot/",
			require => User['glaspot'],
		}

		exec { 'evnet install':
			cwd => "/home/glaspot/evnet/",
			unless => "/usr/bin/python -c 'import evnet'",
			command => "/usr/bin/python setup.py build && python setup.py install",
			require => Git::Clone['evnet'],
		}
}
