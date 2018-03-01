remote_file "#{node[:sybase][:stage_dir]}/#{node[:sybase][:source_archive]}" do
  source "file://#{node[:sybase][:source_archive_path]}"
  owner  node[:sybase][:user]
  group  node[:sybase][:group]
  action :create_if_missing
end


# Extract as root / sudo user but retain ownership (sybase user)
if node[:sybase][:source_archive].split(".")[1] == "zip"
  cmd = "unzip"
else
  cmd = "tar xvf"
end
execute "Extract archive" do
  cwd     node[:sybase][:stage_dir]
  command "#{cmd} #{node[:sybase][:source_archive]}"
  not_if  { ::File.exist?("#{node[:sybase][:stage_dir]}/#{node[:sybase][:installer]}") }
end


template "#{node[:sybase][:stage_dir]}/#{node[:sybase][:rsp][:file]}" do
  source node[:sybase][:rsp][:source]
  owner  node[:sybase][:user]
  group  node[:sybase][:group]
  mode   "0744"
end
