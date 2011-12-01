class tinydns::utils {
	package { "djbdns":
		ensure => "present",
		source => "/etc/puppet/modules/tinydns/files/djbdns_1.05-4+lenny1_amd64.deb",
		provider => dpkg,
	}

	package { "make":
		ensure => "present"
	}

	package { "bsdutils":
		ensure => "present"
	}

	package { "daemontools":
		ensure => "present"
	}
	package { "daemontools-run":
		ensure => "present"
	}
}
