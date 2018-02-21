# Packages
# https://blogs.sap.com/2015/03/27/sap-sybase-database-ase-installation-steps-on-linux/
default[:sybase][:pkgs] = %w[ glib2 openmotif libXp libXt libXtst libXi libXmu libXext libSM libICE libX11 libXtst-devel
  libXi-devel openmotif-devel libXmu-devel libXt-devel libXext-devel libXp-devel libX11-devel libSM-devel libICE-devel ]

default[:sybase][:pkgs_i686] = %w[ glib2.i686 openmotif.i686 libXp.i686 libXt.i686 libXtst.i686 libXi.i686 libXmu.i686
  libXext.i686 libSM.i686 libICE.i686 libX11.i686 ]




# Install media
default[:sybase][:source_archive]      = "Override me"  # Source archieve's file name
default[:sybase][:source_archive_path] = "Override me"  # Full path to the source archive


# Directories and files
default[:sybase][:stage_dir] = Chef::Config[:file_cache_path] # NOTE, ensure /var has enough free space. Could override to "/tmp"
default[:sybase][:installer] = "setup.bin"
