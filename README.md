# sybase

A cookbook that installs Sybase

## Supported Versions / Operating Systems
- Sybase 15.7 on CentOS 6 / RHEL 6
- Sybase 16.0 on CentOS 6 / RHEL 6

## Prerequisites

- A wrapper cookbook that provides the install media. For example, a cookbook that mounts a file server that contains the install media.
- A role that provides the following attributes
```
{
  "sybase": {
    "version": "15.7",
    "source_archive": "ase157_linuxx86_64.tar.gz",
    "source_archive_path": "/mnt/fileserver/sybase/sybase_ase_15/ase157_linuxx86_64.tar.gz",
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
Sybase 16 requires an additional attribute in the role
```
rsc {
  "config_scc_repository_pwd": "password"
}
```
---
* Note, source archive is expected to be either a `tar.gz` archive or a `zip` archive. Additionally, it is assumed that the archive does not extract into a single directory. The contents of the archive (setup.bin for example) will land in the same directory that the source
archive lives (chef cache)


## Testing

This cookbook can be tested with Test Kitchen using CentOS 6
```
berks install
kitchen verify
```

#### Example .kitchen.yml
The following example will deploy Sybase 15.7 and Sybase 16 and then test both configurations. You will need to
tailor this configuration to your environment.

* Note, you may need to include a recipe in the run list that configures a mountpoint for the source media. In
our environment, we have a cookbook that does this and is included in our roles.
```
---
driver:
  name: vagrant
  customize:
    cpus: 2
    memory: 2024
    cpuexecutioncap: 70
provisioner:
  name: chef_solo
  always_update_cookbooks: true
verifier:
  name: inspec
platforms:
  - name: centos-6.9

suites:
  - name: "sybase15"
    run_list:
      - recipe[sybase::default]
    verifier:
      inspec_tests:
        - test/recipes
    attributes:
      sybase:
        version: "15.7"
        source_archive: "ase157_linuxx86-64.tgz"
        source_archive_path: "/mnt/atlas/software/databases/sybase/sybase_ASE_15.7/ase157_linuxx86-64.tgz"
        rsp:
          sybase_product_license_type: "developer"
          sybase_notification_smtp_hostname: ""
          sybase_notification_recipient_email: ""
          sy_cfg_ase_password: "password"
          sy_cfg_sm_password: "password"
          config_scc_csi_sccadmin_pwd: "passowrd"
          config_scc_csi_uafadmin_pwd: "password"

  - name: "sybase16"
    run_list:
      - recipe[sybase::default]
    verifier:
      inspec_tests:
        - test/recipes
    attributes:
      sybase:
        version: "16.0"
        source_archive: "ase16_linuxx86_64.zip"
        source_archive_path: "/mnt/fileserver/software/databases/sybase/sybase_ASE_16.0/ase16_linuxx86_64.zip"
        rsp:
          sybase_product_license_type: "developer"
          sybase_notification_smtp_hostname: ""
          sybase_notification_recipient_email: ""
          sy_cfg_ase_password: "password"
          sy_cfg_sm_password: "password"
          config_scc_csi_sccadmin_pwd: "passowrd"
          config_scc_csi_uafadmin_pwd: "password"
          config_scc_repository_pwd: "password" # NOTE: V 16 specific
```
