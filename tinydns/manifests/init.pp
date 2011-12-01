class tinydns {
	# Do work.
	class { 'tinydns::setup':
		subnet => "10.0.2",
	}
}
