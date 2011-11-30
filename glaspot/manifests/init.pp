class glaspot{
	package { 'subversion':
		ensure => installed,
	}

	package { 'python-dev':
		ensure => installed,
	}

	user { 'glaspot':
		ensure => present,
		home => '/home/glaspot/',
		managehome => true,
	}

	file { '/home/glaspot/glaspot/':
		ensure => directory,
		mode => 0640,
		owner => glaspot,
		require => User['glaspot'],
	}


	subversion::checkout { "glaspot":
		repopath => "/glaspot",
		workingdir => "/home/glaspot/glaspot/",
		host	=> "glastopf.org",
		method	=> "svn",
		svnuser => "glaspot",
		port 	=> "9090",
		require	=> File['/home/glaspot/glaspot/'],
	}
	
	php_apd::install { "apd": }
	glaspot::evnet::install { "evnet install": }
}
