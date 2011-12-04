#!/bin/bash

# Bootstrap a VM to be a glaspot honeypot.
puppet_modules="/vagrant/puppet-modules"
node_definitions="$puppet_modules/nodes/site.pp"
aptitude -y install puppet
puppet apply --modulepath $puppet_modules -e "include glaspot"
puppet apply --verbose --modulepath $puppet_modules $node_definitions
