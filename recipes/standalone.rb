#
# Cookbook Name:: autofs
# Recipe:: standalone
#
# Copyright 2013, Failcode
#
# All rights reserved - Do Not Redistribute
#

include_recipe "autofs"

template "/etc/auto.master" do
  source "auto.master.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :smb => false,
    :net => false,
    :maps => node[:autofs][:maps]
  )
  notifies :reload, resources(:service => "autofs"), :immediately
end

node[:autofs][:maps].each do |map, args|
  template args[:source].gsub(/file:/, '') do
    owner "root"
    group "root"
    mode 0644
    source "auto.map.erb"
    variables(:keys => args[:keys])
    notifies :reload, resources(:service => "autofs"), :immediately
  end
end
