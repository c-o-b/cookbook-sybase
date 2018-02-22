# Check for installed packages
# Cannot  check for 32 bit packages
packages = %w[ glib2 openmotif libXp libXt libXtst libXi libXmu libXext libSM libICE libX11 libXtst-devel libXi-devel
  openmotif-devel libXmu-devel libXt-devel libXext-devel libXp-devel libX11-devel libSM-devel libICE-devel ]

packages.each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end


# Check ports
[22, 5000, 5001, 4900, 8282, 8283, 9999 ].each do |port|
  describe port port do
    it { should be_listening }
  end
end


# Check for directories
base="/usr/local/sybase/15.7"
[ "#{base}", "#{base}/ASE-15_0", "/var/log/sybase/15.7" ].each do |dir|
  describe file(dir) do
    it { should be_directory }
  end
end

# Check for ENV files
base="/usr/local/sybase/15.7"
[ "#{base}/SYBASE.env", "#{base}/SYBASE.sh", "#{base}/SYBASE.csh" ].each do |dir|
  describe file(dir) do
    it { should be_file }
  end
end

# Check for dat files
base="/usr/local/sybase/15.7/data"
[ "#{base}/master.dat", "#{base}/sysprocs.dat", "#{base}/sybsysdb.dat", "#{base}/tempdbdev.dat", "#{base}/sybmgmtdb.dat" ].each do |dir|
  describe file(dir) do
    it { should be_file }
  end
end

# Check for log files
base="/var/log/sybase/15.7"
[ "#{base}/sybase.log", "#{base}/sybase_bs.log", "/etc/ld.so.conf.d/sybase.conf" ].each do |dir|
  describe file(dir) do
    it { should be_file }
  end
end


# Make sure exec-shield is disabled
describe command('grep -v \'^#\' /etc/sysctl.conf | grep "\kernel.exec-shield=0\b"') do
  its('exit_status') { should eq 0 }
end


# Make sure ldconfig -v shows SYBASE paths
cmd='ldconfig -v | grep'
[ "#{cmd} /ASE-15_0/lib", "#{cmd} /DataAccess64/ODBC/lib", "#{cmd} /DataAccess/ODBC/lib", "#{cmd} /OCS-15_0/lib", "#{cmd} /OCS-15_0/lib3p64", "#{cmd} /OCS-15_0/lib3p" ].each do |path|
  describe command(path) do
    its('exit_status') { should eq 0 }
  end
end
