version = inspec.command('sudo ls /usr/local/sybase/ | tr -d "\n"').stdout
sybasehome = "/usr/local/sybase/#{version}"
logdir     = "/var/log/sybase/#{version}"
datadir    = "#{sybasehome}/data"
asedir     = "#{sybasehome}/ASE-16_0"
ocsdir     = "#{sybasehome}/OCS-16_0"
if version == "15.7"
  asedir     = "#{sybasehome}/ASE-15_0"
  ocsdir     = "#{sybasehome}/OCS-15_0"
end


# Check for installed packages
# Cannot  check for 32 bit packages
packages = %w[ glib2 openmotif libXp libXt libXtst libXi libXmu libXext libSM libICE libX11 libXtst-devel libXi-devel
  openmotif-devel libXmu-devel libXt-devel libXext-devel libXp-devel libX11-devel libSM-devel libICE-devel ]

packages.each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end


# Check for users
%w[ sybase ].each do |user|
  describe user(user) do
    it { should exist }
  end
end

# Check ports
[22, 5000, 5001, 4900, 8282, 8283, 9999 ].each do |port|
  describe port port do
    it { should be_listening }
  end
end


# Check for base and log directories
%W[ #{sybasehome} #{asedir} #{logdir} ].each do |dir|
  describe file(dir) do
    it { should be_directory }
  end
end


# Make sure ld paths are valid
dirs = %W[ #{asedir}/lib #{asedir}/symlib #{sybasehome}/DataAccess64/ODBC/lib #{sybasehome}/DataAccess/ODBC/lib
  #{ocsdir}/lib #{ocsdir}/lib3p64 #{ocsdir}/lib3p ].each do |dir|
  describe file(dir) do
    it { should be_directory }
  end
end


# Check for ENV files
dirs = %W[ #{sybasehome}/SYBASE.env #{sybasehome}/SYBASE.sh #{sybasehome}/SYBASE.csh ].each do |dir|
  describe file(dir) do
    it { should be_file }
  end
end


# Check for dat files
dirs = %W[ #{datadir}/master.dat #{datadir}/sysprocs.dat #{datadir}/sybsysdb.dat #{datadir}/tempdbdev.dat #{datadir}/sybmgmtdb.dat ].each do |dir|
  describe file(dir) do
    it { should be_file }
  end
end


# Check for log files
dirs = %W[ #{logdir}/sybase.log #{logdir}/sybase_bs.log /etc/ld.so.conf.d/sybase.conf ].each do |dir|
  describe file(dir) do
    it { should be_file }
  end
end


# Make sure ldconfig -v shows SYBASE paths
cmd='ldconfig -v | grep'
[ "#{cmd} #{asedir}/lib", "#{cmd} /DataAccess64/ODBC/lib", "#{cmd} /DataAccess/ODBC/lib", "#{cmd} #{ocsdir}/lib", \
  "#{cmd} #{ocsdir}/lib3p64", "#{cmd} #{ocsdir}/lib3p" ].each do |path|
  describe command(path) do
    its('exit_status') { should eq 0 }
  end
end


# Make sure exec-shield is disabled
describe command('grep -v \'^#\' /etc/sysctl.conf | grep "\kernel.exec-shield=0\b"') do
  its('exit_status') { should eq 0 }
end


# Make sure dataserver is installed and returns a version
describe command("#{asedir}/bin/dataserver -v") do
  its('exit_status') { should eq 0 }
end
