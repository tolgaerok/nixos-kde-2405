{
  config,
  pkgs,
  lib,
  ...
}:

{
  # AMD-GPU related
  environment.systemPackages = with pkgs; [
    amdvlk
    drivers.i686Linux.amdvlk
    radeontop
    rocm-opencl-icd
    rocm-opencl-runtime
    xorg.xf86videoamdgpu
  ];
}

