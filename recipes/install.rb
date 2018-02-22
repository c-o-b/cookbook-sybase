# Create log directory
directory node[:sybase][:log_dir] do
  owner node[:sybase][:user]
  group node[:sybase][:group]
  mode '0755'
  recursive true
  action :create
end


# Create base dir
directory node[:sybase][:rsp][:user_install_dir] do
  owner node[:sybase][:user]
  group node[:sybase][:group]
  mode  '0755'
  recursive true
  action :create
end


# Create data directory
directory "#{node[:sybase][:rsp][:user_install_dir]}/data" do
  owner node[:sybase][:user]
  group node[:sybase][:group]
  mode  '0755'
  recursive true
  action :create
end


# Place init script
template node[:sybase][:initd][:file] do
  source node[:sybase][:initd][:template]
  owner  'root'
  group  'root'
  mode   '0744'
end


# Disable exec-sheild per Sybase install guide: http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc01002.0321/doc/html/jfo1260972820954.html
execute 'Disable exec-shield' do
  command "echo kernel.exec-shield=0 >> /etc/sysctl.conf && sysctl -p"
  not_if 'grep -v \'^#\' /etc/sysctl.conf | grep "\kernel.exec-shield=0\b"' # returns 0 if kernel exec-shield is disabled
end


# Update the directories after the install
chown = "chown -R #{node[:sybase][:user]}:#{node[:sybase][:group]}"
execute 'permissions' do
  command "#{chown} #{node[:sybase][:rsp][:user_install_dir]} && #{chown} #{node[:sybase][:log_dir]}"
  action :nothing
end


# Install Sybase after setting permissions
execute 'Install Sybase' do
  user     'root'
  cwd      node[:sybase][:stage_dir]
  command  "su #{node[:sybase][:user]} -c \"#{node[:sybase][:install_cmd]}\""
  action   :run
  notifies :run, 'execute[permissions]', :before
  not_if "#{node[:sybase][:initd][:file]} status"
end


# Update ld config
template node[:sybase][:ld][:file] do
  source node[:sybase][:ld][:template]
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :run, 'execute[updateld]', :immediately
end


execute 'updateld' do
  command 'ldconfig -v'
  action  :nothing
end
