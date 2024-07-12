{
  config,
  pkgs,
  lib,
  ...
}:

# AMD-GPU related

with lib;
let
  cfg = config.drivers.amdgpu;
in
{
  imports = [ ../openGL/opengl.nix ];
  options.drivers.amdgpu = {
    enable = mkEnableOption "Enable AMD Drivers";
  };
  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
    services.xserver.videoDrivers = [ "amdgpu" ];
  };

  # [AMD/ATI] Thames [Radeon HD 7550M/7570M/7650M]
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "amdgpu" ];
}
