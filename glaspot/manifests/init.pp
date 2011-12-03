# Glaspot
# Jacques Uber (uberj)


# How to install in non-defualt dir.
# ----------------------------------
# By default everything will be installed into "opt". If you would like to install things
# into a different base dir, pass the basedir option to evnet or glaspot with the dir of your choice.
# DO NOT PASS FUNKY STUFF TO PHP_APD UNLESS YOU KNOW WHAT YOU ARE DOING. read the code.
# Let's say you want to install evnet into '/var'. Change the class declaration to
#
#		class { "glaspot::evnet": basedir => 'var' }
#
# Not the lack of a preceding '/'.


class glaspot {
	class { "php_apd::install": }
	class { "evnet::install": }
	class { "glaspot::install": }
}
