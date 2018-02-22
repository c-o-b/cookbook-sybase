remote_file "#{node[:sybase][:stage_dir]}/#{node[:sybase][:source_archive]}" do
  source "file://#{node[:sybase][:source_archive_path]}"
  owner  node[:sybase][:user]
  group  node[:sybase][:group]
  action :create_if_missing
end


# Extract as root / sudo user but retain ownership (sybase user)
execute "Extract archive" do
  cwd     node[:sybase][:stage_dir]
  command "tar xvf #{node[:sybase][:source_archive]}"
  not_if  { ::File.exist?("#{node[:sybase][:stage_dir]}/#{node[:sybase][:installer]}") }
end


template "#{node[:sybase][:stage_dir]}/#{node[:sybase][:rsp][:file]}" do
  source node[:sybase][:rsp][:source]
  owner  node[:sybase][:user]
  group  node[:sybase][:group]
  mode   "0744"
end
