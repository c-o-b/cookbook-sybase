# Response file
default[:sybase][:rsp][:file]   = "resp_file.txt" # NOTE, sybase uses the .txt extension
default[:sybase][:rsp][:source] = "resp_file.txt.erb"


# Response file parameters
default[:sybase][:rsp][:run_silent]                 = "true"
default[:sybase][:rsp][:user_install_dir]           = "/usr/bin/sybase"
default[:sybase][:rsp][:install_older_version]      = "false"
default[:sybase][:rsp][:do_update_install]          = "false"
default[:sybase][:rsp][:choosen_install_set]        = "Typical"
default[:sybase][:rsp][:sybase_prouct_license_type] = "evaluate"
default[:sybase][:rsp][:sysam_license_source]                     = "proceed_without_license" # NOTE: Default example response file value
default[:sybase][:rsp][:sysam_license_file_pathname]              = ""
default[:sybase][:rsp][:sysam_existing_license_server_hostname]   = ""
default[:sybase][:rsp][:sysam_existing_license_server_portnumber] = ""
default[:sybase][:rsp][:sysam_product_edition] = "Enterprise Edition"
default[:sybase][:rsp][:sysam_license_type]    = "CP :  CPU License"

default[:sybase][:rsp][:sysam_notifcation_enable]          = "true"
default[:sybase][:rsp][:sysam_notifcation_smtp_hostname]   = ""    # NOTE: Override this
default[:sybase][:rsp][:sysam_notifcation_smtp_portnumber] = "25"
default[:sybase][:rsp][:sysam_notifcation_sender_email]    = node[:hostname]
default[:sybase][:rsp][:sysam_notifcation_recipient_email] = ""    # NOTE: Override this
default[:sybase][:rsp][:sysam_notifcation_email_severity]  = "WARNING"

default[:sybase][:rsp][:sy_config_ase_server] = "true"
default[:sybase][:rsp][:sy_config_bs_server]  = "true"
default[:sybase][:rsp][:sy_config_xp_server]  = "true"
default[:sybase][:rsp][:sy_config_js_server]  = "true"
default[:sybase][:rsp][:sy_config_sm_server]  = "true"
default[:sybase][:rsp][:sy_config_scc_server] = "true"

default[:sybase][:rsp][:sy_cfg_ase_server_name] = "SYBASE"
default[:sybase][:rsp][:sy_cfg_ase_port_number] = "5000"
default[:sybase][:rsp][:sy_cfg_ase_appl_type] = "MIXED"
default[:sybase][:rsp][:sy_cfg_ase_pagesize] = "4k"
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


default[:sybase][:rsp][:sy_cfg_ase_error_log]    = "/var/log/sybase.log" # NOTE: Not a default value
default[:sybase][:rsp][:sy_cfg_ase_pci_enable]   = 
default[:sybase][:rsp][:sy_cfg_ase_pci_dev_name] =
default[:sybase][:rsp][:sy_cfg_ase_pci_dev_size] =
default[:sybase][:rsp][:sy_cfg_ase_pci_db_size]  =


default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
default[:sybase][:rsp][:] =
