{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

{

  # ---------------------------------------------------------------------
  # Direct Rendering Infrastructure (DRI) support, both for 32-bit and 64-bit, and 
  # Make sure opengl is enabled
  #---------------------------------------------------------------------
  hardware = {
    opengl = {
      enable = true;
      # AllowFlipping = "Off";
      driSupport = lib.mkDefault true;
      driSupport32Bit = lib.mkDefault true;

      #---------------------------------------------------------------------
      # Install additional packages that improve graphics performance and compatibility.
      #---------------------------------------------------------------------
      extraPackages = with pkgs; [
        # nvidia-thrust
        # nvidia-thrust-cuda
        # nvidia-thrust-intel
        amdvlk
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        libvdpau-va-gl
        nvidia-vaapi-driver
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        vulkan-validation-layers
      ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };
  };
}
