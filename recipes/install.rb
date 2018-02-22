# Create log directory
directory node[:sybase][:log_dir] do
  owner node[:sybase][:user]
  group node[:sybase][:group]
  mode '0744'
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


# Disable exec-sheild per Sybase install guide: http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc01002.0321/doc/html/jfo1260972820954.html
execute 'Disable exec-shield' do
  command "echo kernel.exec-shield=0 >> /etc/sysctl.conf && sysctl -p"
  not_if 'grep -v \'^#\' /etc/sysctl.conf | grep "\kernel.exec-shield=0\b"' # returns 0 if kernel exec-shield is disabled
end


# Install Sybase
#execute 'Install Sybase' do
#  cwd      node[:sybase][:stage_dir]
#  command  node[:sybase][:install_cmd]
#  action   :run
#end # TODO: Add a gaurd


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
