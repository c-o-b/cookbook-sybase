# sybase

A cookbook that installs Sybase

## Supported Versions / Operating Systems

Sybase 15.7 on CentOS 6
Sybase 15.7 on RHEL 6

## Prerequisites

- A wrapper cookbook that provides the install media. For example, a cookbook that mounts a file server that contains the install media.
- A role that provides the following attributes
  - version
  - source_archive
  - source_archive_path
  - rsp
    - user_install_dir
    - sybase_product_license_type
    - sybase_notification_smtp_hostname
    - sybase_notification_recipient_email
    - sy_cfg_ase_password
    - sy_cfg_sm_password
    - config_scc_csi_sccadmin_pwd
    - config_scc_csi_uafadmin_pwd

## Testing

This cookbook can be tested with Test Kitchen using CentOS 6
```
kitchen verify
```
