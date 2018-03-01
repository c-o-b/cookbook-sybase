# Create log directories
dirs = [node[:sybase][:home], node[:sybase][:rsp][:user_install_dir], node[:sybase][:log_home], node[:sybase][:log_dir]]
dirs.each do |dir|
  directory dir do
    owner node[:sybase][:user]
    group node[:sybase][:group]
    mode '0755'
    recursive true
    action :create
  end
end

# Place init script
template node[:sybase][:initd][:file] do
  source node[:sybase][:initd][:template]
  owner  'root'
  group  'root'
  mode   '0755'
end


# Disable exec-sheild per Sybase install guide: http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc01002.0321/doc/html/jfo1260972820954.html
execute 'Disable exec-shield' do
  command "echo kernel.exec-shield=0 >> /etc/sysctl.conf && sysctl -p"
  not_if  'grep -v \'^#\' /etc/sysctl.conf | grep "\kernel.exec-shield=0\b"' # returns 0 if kernel exec-shield is disabled
end


# Update the directories after the install
chown = "chown -R #{node[:sybase][:user]}:#{node[:sybase][:group]}"
execute 'permissions' do
  command "#{chown} #{node[:sybase][:home]} && #{chown} #{node[:sybase][:log_home]}"
  user    'root'
  action  :nothing
end


# Install Sybase after setting permissions
execute 'Install Sybase' do
  user     node[:sybase][:user]
  cwd      node[:sybase][:stage_dir]
  command  node[:sybase][:install_cmd]
  action   :run
  notifies :run, 'execute[permissions]', :before
  not_if { ::File.exist?("#{node[:sybase][:rsp][:user_install_dir]}/#{node[:sybase][:ase_dir]}/bin/dataserver") }
end


# Manage library config file
template node[:sybase][:ld][:file] do
  source   node[:sybase][:ld][:template]
  owner    'root'
  group    'root'
  mode     '0644'
  notifies :run, 'execute[updateld]', :immediately
end


# Update library paths, required for interacting with
# init script and sybase binaries
execute 'updateld' do
  command 'ldconfig -v'
  action  :nothing
end
