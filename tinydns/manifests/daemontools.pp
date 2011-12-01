# This class needs to have the daemontools package installed.
class tinydns::daemontools {
	Package['daemontools'] -> Class['tinydns::daemontools']

	service { "dnscache":
		provider 	=> "daemontools",
		path 			=> "/etc/dnscache";
	}

	service { "dnscache-log":
		provider 	=> "daemontools",
		path 			=> "/etc/dnscache/log";
	}

	service { "tinydns":
		provider 	=> "daemontools",
		path 			=> "/etc/tinydns";
	}
	
	service { "tinydns-log":
		provider 	=> "daemontools",
		path 			=> "/etc/tinydns/log";
	}
}
