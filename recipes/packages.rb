# Upgrade 64 bit packages and libraries to avoid
# version conflicts when installing 32 bit version
package node[:sybase][:pkgs] do
  action :upgrade
end

package node[:sybase][:pkgs_i686] do
  action :upgrade
end
