# subet: which network should dnscache resolve for.
class tinydns::setup ( $subnet ){
	include tinydns::users # Add users
	include tinydns::daemontools #start the servies dnscache and tinydns
	include tinydns::utils # Contains all packages.

	exec { "rebuild-tinydns-data":
		cwd 				=> "/etc/tinydns/root",
		command 		=> "/usr/bin/make",
		refreshonly => true,
		require 		=> [Package["djbdns"], Exec["tinydns-setup"], Exec["dnscache-setup"]],
		notify 			=> Service["dnscache"]
	}
	exec { "tinydns-setup":
		command => "/usr/bin/tinydns-conf tinydns dnslog /etc/tinydns 127.0.0.1",
		creates => "/etc/tinydns",
		 require => [Class['tinydns::utils'],Class['tinydns::users']]
	}
	exec { "dnscache-setup":
		command => "/usr/bin/dnscache-conf dnscache dnslog /etc/dnscache $ipaddress",
		creates => "/etc/dnscache",
		require => [Class['tinydns::utils'],Class['tinydns::users']]
	}
	file { "/etc/service":
		ensure 	=> directory,
		mode 		=> 0640,
		require => [Exec["tinydns-setup"], Exec["dnscache-setup"]],
	}
	file { "/etc/service/tinydns":
		ensure 	=> link,
		target 	=> "/etc/tinydns",
		require => Exec["tinydns-setup"],
	}
	file { "/etc/service/dnscache":
		ensure 	=> link,
		target 	=> "/etc/dnscache",
		require => Exec["dnscache-setup"],
	}
	file { "/etc/dnscache/root/ip/${subnet}":
		ensure 	=> present,
		mode 	=> 644,
		owner 	=> "root",
		group 	=> "root",
		require => Exec["dnscache-setup"],
	}
	file { "/etc/tinydns/log/run":
		require => Exec["tinydns-setup"],
		notify 	=> Service["tinydns-log"],
		ensure 	=> present,
		owner 	=> "root",
		group 	=> "root",
		mode 	=> "0755",
		source 	=> "puppet:///modules/tinydns/tinydns-log",
	}
	file { "/etc/dnscache/log/run":
		require => Exec["dnscache-setup"],
		notify 	=> Service["dnscache-log"],
		owner 	=> "root",
		group 	=> "root",
		mode 		=> "0755",
		source 	=> "puppet:///modules/tinydns/dnscache-log",
	}
	file { "/etc/dnscache/root/servers/internal":
		require => Exec["dnscache-setup"],
	 	ensure 	=> present,
		content => "127.0.0.1",
	}
}
