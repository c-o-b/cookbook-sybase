# sybase

A cookbook that installs Sybase

## Supported Versions / Operating Systems

Sybase 15.7 on CentOS 6
Sybase 15.7 on RHEL 6

## Prerequisites

- A wrapper cookbook that provides the install media. For example, a cookbook that mounts a file server that contains the install media.
- A role that provides the following attributes
```
{
  "sybase": {
    "version": "16.0",
    "source_archive": "ase16_linuxx86_64.tar.gz",
    "source_archive_path": "/mnt/fileserver/sybase/sybase_ase_16.0/ase16_linuxx86_64.tar.gz",
    "rsp": {
      "sybase_product_license_type": "developer",
      "sybase_notification_smtp_hostname": "smtp.server.localnet",
      "sybase_notification_recipient_email": "support@company.com",
      "sy_cfg_ase_password": "password",
      "sy_cfg_sm_password": "password",
      "config_scc_csi_sccadmin_pwd": "password",
      "config_scc_csi_uafadmin_pwd": "password"
    }
  }
}
```
---
* Note, source archive is expected to be either a tar.gz archive or a zip archive. Additionally, it is assumed that the archive does not extract into a single directory. The contents of the archive (setup.bin for example) will land in the same directory that the source
archive lives (chef cache)


## Testing

This cookbook can be tested with Test Kitchen using CentOS 6
```
kitchen verify
```
