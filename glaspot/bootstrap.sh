#!/bin/bash

# Bootstrap a VM to be a glaspot honeypot.
puppet_modules="/vagrant/puppet-modules"
aptitude -y install puppet
echo "modulepath = $puppet_modules" >> /etc/puppet/puppet.conf
puppet apply -e "include glaspot"
