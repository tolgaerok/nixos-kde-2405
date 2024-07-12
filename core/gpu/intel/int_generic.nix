{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.drivers.intel;
in

#---------------------------------------------------------------------
# Works Well on various Intel Mesa HD GPUs
#---------------------------------------------------------------------
{  
  options.drivers.intel = {
    enable = mkEnableOption "Enable Intel Graphics Drivers";
  };

  config = mkIf cfg.enable {    
    #---------------------------------------------------------------------
    # Laptop configuration
    #---------------------------------------------------------------------
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };

    services = {
      acpid.enable = true;                  # Enable ACPI daemon for handling power events and managing power configurations
      fwupd.enable = true;                  # Enable firmware updates using fwupd, a daemon to handle firmware updates on Linux systems
      power-profiles-daemon.enable = true;  # Enable the power-profiles-daemon, which manages power profiles
      thermald.enable = true;               # Enable Intel's thermal daemon for managing thermal zones and cooling policies
      upower.enable = true;                 # Enable UPower, a daemon for power management and battery monitoring

      xserver = {
        videoDrivers = [ "i965" ];          # Use the modesetting driver for X server, which is often used with Intel GPUs
        exportConfiguration = true;         # Export the X server configuration, making it available to other components
      };
    };

    #---------------------------------------------------------------------
    # Update microcode when available
    #---------------------------------------------------------------------
    hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };
}
