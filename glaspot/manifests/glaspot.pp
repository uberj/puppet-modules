# Params
# basedir = place where glaspot will be installed.

class glaspot::install ( $basedir = "opt" ){

	package { "subversion":
		ensure => installed,
	}

	package { "python-dev":
		ensure => installed,
	}
	package { "python-chardet":
		ensure => installed,
	}

	user { "glaspot":
		ensure => present,
		home => "/bin/false",
		managehome => false,
	}

	file { "/${basedir}/glaspot/":
		ensure => directory,
		mode => 0640,
		owner => glaspot,
		require => User["glaspot"],
	}

	subversion::checkout { "glaspot":
		repopath => "/glaspot",
		workingdir => "/${basedir}/glaspot/",
		host	=> "glastopf.org",
		method	=> "svn",
		svnuser => "glaspot",
		port 	=> "9090",
		require	=> File["/${basedir}/glaspot/"],
	}
}
