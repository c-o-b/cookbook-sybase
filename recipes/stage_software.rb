# TODO, do not download install media if already installed
# TODO, verify that chef cache actually cleans up after itself

remote_file "#{node[:sybase][:stage_dir]}/#{node[:sybase][:source_archive]}" do
  source "file://#{node[:sybase][:source_archive_path]}"
  action :create_if_missing
end


execute "Extract archive" do
  cwd      node[:sybase][:stage_dir]
  command "tar xvf #{node[:sybase][:source_archive]}"
  not_if  { ::File.exist?("#{node[:sybase][:stage_dir]}/#{node[:sybase][:installer]}") }
end


template "#{node[:sybase][:stage_dir]}/#{node[:sybase][:rsp][:file]}" do
  source node[:sybase][:rsp][:source]
  owner  "root"
  group  "root"
  mode   "0744"
end
