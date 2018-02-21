# Check for installed packages
# Cannot  check for 32 bit packages
packages = %w[ glib2 openmotif libXp libXt libXtst libXi libXmu libXext libSM libICE libX11 libXtst-devel libXi-devel
  openmotif-devel libXmu-devel libXt-devel libXext-devel libXp-devel libX11-devel libSM-devel libICE-devel ]

packages.each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end
