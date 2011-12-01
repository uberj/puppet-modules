class tinydns {
	# Do work.
	
	include tinydns::users
	include tinydns::daemontools
	include tinydns::utils # Contains all packages.
	include tinydns::setup
	Class['tinydns::utils'] -> Class['tinydns::setup']
	Class['tinydns::users'] -> Class['tinydns::setup']
	Class['tinydns::daemontools'] -> Class['tinydns::setup']

}
