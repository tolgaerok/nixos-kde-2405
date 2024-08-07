<<<<<<< HEAD
{ config, pkgs, lib, ... }:

# AMD-GPU related

{
  imports = [
    # ./amdgpu-pro.nix
    ../../openGL/opengl.nix

  ];

  # Packages related to AMD-GPU graphics
  environment.systemPackages = with pkgs; [
    amdvlk
    driversi686Linux.amdvlk
    radeontop
    rocm-opencl-icd
    rocm-opencl-runtime
    xorg.xf86videoamdgpu

  ];

  #enableRedistributableFirmware = true;

  # [AMD/ATI] Thames [Radeon HD 7550M/7570M/7650M]
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
=======
{ ... }:
{

  imports = [
    # ./amd_pro.nix
    ../openGL/opengl.nix
    ./amd_drivers.nix
    ./amd_pkgs.nix
  ];
>>>>>>> 9816fb0 ((ツ)_/¯ Edit: 12-07-2024 10:36:15 PM)
}
