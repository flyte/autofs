#
# Cookbook Name:: autofs
# Recipe:: default
#
# Copyright 2010, 37signals
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nfs"

package "autofs"

service "autofs" do
	supports [ :start, :stop, :restart, :reload, :status ]
	action [ :enable, :start ]
end


