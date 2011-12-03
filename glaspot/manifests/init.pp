# Params
# basedir = place where glaspot will be installed.
# 
# By defualt everything will be installed into "opt". I've been doubly verbose about it.
# If you want to though, you can pass a different dir like "/tmp" or something.

class glaspot {
	class { "php_apd::install": }
	class { "glaspot::evnet": }
	class { "glaspot::install": }
}
