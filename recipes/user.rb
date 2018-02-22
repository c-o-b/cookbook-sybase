group node[:sybase][:group] do
  action :create
end

user node[:sybase][:user] do
  shell       "/bin/bash"
  group       node[:sybase][:group]
  home        "/home/#{node[:sybase][:user]}"
  manage_home true
  action      :create
end
