default[:sybase][:version] = "15.7"  # Used by response file attributes


# User and group to run sybase under
default[:sybase][:user] = "root" # TODO: Validate if this should be changed.
default[:sybase][:group] = node[:sybase][:user]


# Packages https://blogs.sap.com/2015/03/27/sap-sybase-database-ase-installation-steps-on-linux/
default[:sybase][:pkgs] = %w[ glib2 openmotif libXp libXt libXtst libXi libXmu libXext libSM libICE libX11 libXtst-devel
  libXi-devel openmotif-devel libXmu-devel libXt-devel libXext-devel libXp-devel libX11-devel libSM-devel libICE-devel ]

default[:sybase][:pkgs_i686] = %w[ glib2.i686 openmotif.i686 libXp.i686 libXt.i686 libXtst.i686 libXi.i686 libXmu.i686
  libXext.i686 libSM.i686 libICE.i686 libX11.i686 ]


# Install media
default[:sybase][:source_archive]      = "Override me"  # Source archieve's file name with extension
default[:sybase][:source_archive_path] = "Override me"  # Full path to the source archive including the file name


# Directories and files
default[:sybase][:stage_dir] = Chef::Config[:file_cache_path] # NOTE, ensure /var has enough free space. Could override to "/tmp"
default[:sybase][:installer] = "setup.bin"
default[:sybase][:log_dir]   = "/var/log/sybase/#{node[:sybase][:version]}"


# Library config file
default[:sybase][:ld][:file]      = "/etc/ld.so.conf.d/sybase.conf"
default[:sybase][:ld][:template]  = "ld.so.conf.erb"


# Response file
default[:sybase][:rsp][:file]   = "resp_file.txt" # NOTE, sybase uses the .txt extension
default[:sybase][:rsp][:source] = "resp_file.txt.erb"


# Install command (full path to binary, implicity path to response file)
default[:sybase][:install_cmd] = "#{node[:sybase][:stage_dir]}/#{node[:sybase][:installer]} \
  -f #{node[:sybase][:rsp][:file]} \
  -DAGREE_TO_SYBASE_LICENSE=true \
  -DRUN_SILENT=true \
  -i silent"



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                Response file parameters                   #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
default[:sybase][:rsp][:run_silent] = "true"
default[:sybase][:rsp][:user_install_dir] = "/usr/local/sybase/#{node[:sybase][:version]}"
default[:sybase][:rsp][:install_older_version] = "false"
default[:sybase][:rsp][:do_update_install] = "false"
default[:sybase][:rsp][:choosen_install_set] = "Full"  # NOTE: Default is "Typical" # NOTE: Full includes the SCC component
default[:sybase][:rsp][:sybase_prouct_license_type] = "evaluate"
default[:sybase][:rsp][:sysam_license_source] = "proceed_without_license" # NOTE: Default example response file value
default[:sybase][:rsp][:sysam_license_file_pathname] = ""
default[:sybase][:rsp][:sysam_existing_license_server_hostname] = ""
default[:sybase][:rsp][:sysam_existing_license_server_portnumber] = ""
default[:sybase][:rsp][:sysam_product_edition] = "Enterprise Edition"
default[:sybase][:rsp][:sysam_license_type] = "CP :  CPU License"
default[:sybase][:rsp][:sysam_notifcation_enable] = "true"
default[:sybase][:rsp][:sysam_notifcation_smtp_hostname] = ""    # NOTE: Override this
default[:sybase][:rsp][:sysam_notifcation_smtp_portnumber] = "25"
default[:sybase][:rsp][:sysam_notifcation_sender_email] = node[:hostname]
default[:sybase][:rsp][:sysam_notifcation_recipient_email] = ""    # NOTE: Override this
default[:sybase][:rsp][:sysam_notifcation_email_severity]  = "WARNING"
default[:sybase][:rsp][:sy_config_ase_server] = "true"
default[:sybase][:rsp][:sy_config_bs_server] = "true"
default[:sybase][:rsp][:sy_config_xp_server] = "true"
default[:sybase][:rsp][:sy_config_js_server] = "true"
default[:sybase][:rsp][:sy_config_sm_server] = "true"
default[:sybase][:rsp][:sy_config_scc_server] = "true"
default[:sybase][:rsp][:sy_cfg_ase_server_name] = "SYBASE"
default[:sybase][:rsp][:sy_cfg_ase_port_number] = "5000"
default[:sybase][:rsp][:sy_cfg_ase_appl_type] = "MIXED"
default[:sybase][:rsp][:sy_cfg_ase_pagesize] = "4k" # NOTE: 2k page size requires 64mb shared kernel memory minimum
default[:sybase][:rsp][:ase_addl_cmd_arg] = ""
default[:sybase][:rsp][:sy_cfg_ase_password] = "sybase" # NOTE: Default example response file value
default[:sybase][:rsp][:sy_cfg_ase_master_dev_name] = "#{node[:sybase][:rsp][:user_install_dir]}/data/master.dat"
default[:sybase][:rsp][:sy_cfg_ase_master_dev_size] = "60"
default[:sybase][:rsp][:sy_cfg_ase_master_db_size]  = "26"
default[:sybase][:rsp][:sy_cfg_ase_sybroc_dev_name] = "#{node[:sybase][:rsp][:user_install_dir]}/data/sysprocs.dat"
default[:sybase][:rsp][:sy_cfg_ase_sybroc_dev_size] = "172"
default[:sybase][:rsp][:sy_cfg_ase_sybroc_db_size]  = "172"
default[:sybase][:rsp][:sy_cfg_ase_sybtemp_dev_name] = "#{node[:sybase][:rsp][:user_install_dir]}/data/sybsysdb.dat"
default[:sybase][:rsp][:sy_cfg_ase_sybtemp_dev_size] = "6"
default[:sybase][:rsp][:sy_cfg_ase_sybtemp_db_size] = "6"
default[:sybase][:rsp][:sy_cfg_ase_error_log]    = "#{node[:sybase][:log_dir]}/sybase.log" # NOTE: Not a default value "/opt/sybase/ASE-15_0/install/SYBASE.log"
default[:sybase][:rsp][:sy_cfg_ase_pci_enable]   = "false"
default[:sybase][:rsp][:sy_cfg_ase_pci_dev_name] = ""
default[:sybase][:rsp][:sy_cfg_ase_pci_dev_size] = ""
default[:sybase][:rsp][:sy_cfg_ase_pci_db_size]  = ""
default[:sybase][:rsp][:sy_cfg_ase_temp_dev_name] = "#{node[:sybase][:rsp][:user_install_dir]}/data/tempdbdev.dat"
default[:sybase][:rsp][:sy_cfg_ase_temp_dev_size] = "100"
default[:sybase][:rsp][:sy_cfg_ase_temp_db_size] = "100"
default[:sybase][:rsp][:sy_cfg_ase_opt_enable] = "false"
default[:sybase][:rsp][:sy_cfg_ase_cpu_number] = ""
default[:sybase][:rsp][:sy_cfg_ase_memory] = ""
default[:sybase][:rsp][:sy_cfg_ase_lang] = ""
default[:sybase][:rsp][:sy_cfg_ase_charset] = ""
default[:sybase][:rsp][:sy_cfg_ase_sortorder] = ""
default[:sybase][:rsp][:sy_cfg_ase_sample_db] = "true" # note: default value is "false"
default[:sybase][:rsp][:sy_cfg_bs_server_name] = "sybase_bs"
default[:sybase][:rsp][:sy_cfg_bs_port_number] = "5001"
default[:sybase][:rsp][:sy_cfg_bs_error_log] = "#{node[:sybase][:log_dir]}/sybase_bs.log"
default[:sybase][:rsp][:bs_addl_cmd_arg] = ""
default[:sybase][:rsp][:sy_cfg_xp_server_name] = "sybase_xp"
default[:sybase][:rsp][:sy_cfg_xp_port_number] = "5003"
default[:sybase][:rsp][:sy_cfg_xp_error_log] = "#{node[:sybase][:log_dir]}/sybase_xp.log"
default[:sybase][:rsp][:sy_cfg_js_server_name] = "sybase_js"
default[:sybase][:rsp][:sy_cfg_js_port_number] = "4900"
default[:sybase][:rsp][:sy_cfg_js_manag_dev_name] = "#{node[:sybase][:rsp][:user_install_dir]}/data/sybmgmtdb.dat"
default[:sybase][:rsp][:sy_cfg_js_manag_dev_size] = "75"
default[:sybase][:rsp][:sy_cfg_js_manag_db_size] = "75"
default[:sybase][:rsp][:sy_cfg_sm_user_name] = "sa"
default[:sybase][:rsp][:sy_cfg_sm_password]  = "" # NOTE: The default value is blank. OVERRIDE
default[:sybase][:rsp][:scc_selfdiscovery_config_udp_adaptor] = "true"
default[:sybase][:rsp][:scc_selfdiscovery_config_jini_adaptor] = "false"
default[:sybase][:rsp][:scc_selfdiscovery_jini_host_name] = "localhost"
default[:sybase][:rsp][:scc_selfdiscovery_jini_port_number] = "4160"
default[:sybase][:rsp][:scc_selfdiscovery_jini_heart_beat_period] = "900"
default[:sybase][:rsp][:config_scc_http_port] = "8282"
default[:sybase][:rsp][:config_scc_https_port] = "8283"
default[:sybase][:rsp][:scc_rmi_port_number] = "9999"
default[:sybase][:rsp][:config_scc_csi_sccadmin_pwd] = "" # NOTE: Default value is blank, override
default[:sybase][:rsp][:config_scc_csi_uafadmin_pwd] = "" # NOTE: Default value is blank, override
default[:sybase][:rsp][:enable_scc_shared_disk] = "false"
default[:sybase][:rsp][:create_scc_instance_name] = node[:hostname]  # NOTE: If blank, uses hostname.
default[:sybase][:rsp][:refresh_scc_instance_type] = "AGENT"
default[:sybase][:rsp][:install_scc_service] = "TRUE"
