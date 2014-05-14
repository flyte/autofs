#
# Cookbook Name:: autofs
# Recipe:: default
#
# Copyright 2010, 37signals
#
# All rights reserved - Do Not Redistribute
#

package "autofs"

# Install smbfs package, unless we are on ubuntu 13.x
package platform?("ubuntu") && node['platform_version'].to_f >= 12.10 ? "cifs-utils" : "smbfs"

service "autofs" do
	supports [ :start, :stop, :restart, :reload, :status ]
	action [ :enable, :start ]
end


