class tinydns::users {
	user { "tinydns":
		ensure	=> present,
		comment => "Tinydns User",
		home 		=> "/dev/null",
		shell 	=> "/bin/false",
		uid 		=> 30000,
	}

	user { "dnscache":
		ensure 	=> present,
		comment => "Dnscache User",
		home 		=> "/dev/null",
		shell 	=> "/bin/false",
		uid 		=> 30001,
	}

	user { "dnslog":
		ensure 	=> present,
		comment => "Djbdns Log User",
		home 		=> "/dev/null",
		shell 	=> "/bin/false",
		uid 		=> 30002,
	}
}
