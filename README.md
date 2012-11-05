Description
===========
Installs/configures autofs drive mounts.

Caveats
=======
Has only been tested with smb mounts.

Doesn't use the existing auto.smb executable file.

Usage
=====
The attribute data structure required (attributes/default.rb):

	default[:yournode][:maps]["/mnt"] = {
		:source	=> "/etc/auto.smb",
		:keys 	=> {
			"media_server" => {
				:options	=> "-fstype=cifs,user=yourusername,pass=yourpassword,uid=yourusername",
				:export		=> "//sambaserver.yourdomain.com/sharename",
				:server		=> ""
			}
		}
	}

Include the recipe in your cookbook, then create the two template files (recipes/default.rb):

	MAPS = node[:yournode][:maps]

	include_recipe "autofs"

	template "/etc/auto.master" do
		source "auto.master.erb"
		cookbook "autofs"
		owner "root"
		group "root"
		mode "0644"
		variables(
			:smb	=> false,
			:net	=> false,
			:maps	=> MAPS
		)
		notifies :reload, resources(:service => "autofs"), :immediately
	end

	MAPS.each do |map, args|
		template args[:source].gsub(/file:/, '') do
			source "auto.map.erb"
			cookbook "autofs"
			owner "root"
			group "root"
			mode 0644
			variables(
				:keys => args[:keys]
			)
			notifies :reload, resources(:service => "autofs"), :immediately
		end
	end


