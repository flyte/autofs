#
# Cookbook Name:: autofs
# Recipe:: default
#
# Copyright 2010, 37signals
#
# All rights reserved - Do Not Redistribute
#

package "autofs"
package "smbfs"

service "autofs" do
	supports [ :start, :stop, :restart, :reload, :status ]
	action [ :enable, :start ]
end


