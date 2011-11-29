class tinydns::setup {
    exec { "rebuild-tinydns-data":
        cwd => "/etc/tinydns/root",
        command => "/usr/bin/make",
        refreshonly => true,
        require => [Package["djbdns"], Exec["tinydns-setup"], Exec["dnscache-setup"]],
        notify => Service["dnscache"]
    }

    exec { "tinydns-setup":
        command => "/usr/bin/tinydns-conf tinydns dnslog /etc/tinydns 127.0.0.1",
        creates => "/etc/tinydns",
        require => Package["djbdns"]
    }

    exec { "dnscache-setup":
        command => "/usr/bin/dnscache-conf dnscache dnslog /etc/dnscache $ipaddress",
        creates => "/etc/dnscache",
        require => Package["djbdns"]
    }

    user { "tinydns":
        ensure => present,
        comment => "Tinydns User",
        home => "/dev/null",
        shell => "/bin/false",
        uid => 30000,
    }

    user { "dnscache":
        ensure => present,
        comment => "Dnscache User",
        home => "/dev/null",
        shell => "/bin/false",
        uid => 30001,
    }

    user { "dnslog":
        ensure => present,
        comment => "Djbdns Log User",
        home => "/dev/null",
        shell => "/bin/false",
        uid => 30002,
    }

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

    file { "/etc/service":
	ensure => directory,
	mode => 0640,
    }

    file { "/etc/service/tinydns":
	ensure => link,
        target => "/etc/tinydns",
        require => [File['/etc/service'], Exec["tinydns-setup"], Exec["dnscache-setup"]]
    }

    file { "/etc/service/dnscache":
	ensure => link,
        target => "/etc/dnscache",
        require => [File['/etc/service'], Exec["tinydns-setup"], Exec["dnscache-setup"]]
    }

    service { "dnscache":
        provider => "daemontools",
        path => "/etc/dnscache";
    }

    service { "dnscache-log":
        provider => "daemontools",
        path => "/etc/dnscache/log";
    }

    service { "tinydns":
        provider => "daemontools",
        path => "/etc/tinydns";
    }

    service { "tinydns-log":
        provider => "daemontools",
        path => "/etc/tinydns/log";
    }

    file { "/etc/tinydns/log/run":
        owner => "root",
        group => "root",
        mode => "0755",
        source => "puppet:///modules/tinydns/tinydns-log",
        require => [Exec["tinydns-setup"], Package["daemontools"], Package["bsdutils"]],
        notify => Service["tinydns-log"]
    }

    file { "/etc/dnscache/log/run":
        owner => "root",
        group => "root",
        mode => "0755",
        source => "puppet:///modules/tinydns/dnscache-log",
        require => [Exec["dnscache-setup"], Package["daemontools"], Package["bsdutils"]],
        notify => Service["dnscache-log"]
    }
    file { "/etc/dnscache/root/servers/internal":
	ensure => present,
	content => "127.0.0.1",
	require => Exec['dnscache-setup'],
    }
}
