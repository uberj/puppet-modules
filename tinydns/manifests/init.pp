class tinydns {
	# Install all util packages before we start to setup all the services.
	Class['tinydns::utils'] -> Class['tinydns::daemontools']
	# Do work.
	class { 'tinydns::setup':
		subnet => "10.0.2",
	}
}
