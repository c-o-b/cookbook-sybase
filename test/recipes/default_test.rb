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
[22, 5000, 5001, 5003, 4900, 4160, 8282, 8283, 9999 ].each do |port|
  describe port port do
    it { should be_listening }
  end
end


# Check for log directory
[ "/usr/local/sybase/15.7", "/var/log/sybase/15.7" ].each do |dir|
  describe file(dir) do
    it { should be_directory }
  end
end


# Make sure exec-shield is disabled
describe command('grep -v \'^#\' /etc/sysctl.conf | grep "\kernel.exec-shield=0\b"') do
  its('exit_status') { should eq 0 }
end
