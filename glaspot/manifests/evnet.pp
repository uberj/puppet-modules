#
# Let's get this working before we make it pretty.
#

class evnet () {
	file { '/home/glaspot/evnet/':
		ensure => directory,
		mode => 0640,
		owner => glaspot,
		require => User['glaspot'],
	}

	git::clone { "evnet":
		source => "https://github.com/rep/evnet.git",
		localtree => "/home/glaspot/",
	}

	exec { 'evnet install':
		path => ['/usr/bin'],
		cwd => "/home/glaspot/evnet/",
		command => "python setup.py build && python setup.py install",
		require => Git::Clone['evnet'],
	}
}
