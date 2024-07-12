{ config, lib, ... }:

with lib;

let
in

#---------------------------------------------------------------------
# Works Well on various Intel Mesa HD GPUs
#---------------------------------------------------------------------

{
  #---------------------------------------------------------------------
  # Power management & Analyze power consumption on Intel-based laptops
  #---------------------------------------------------------------------
  networking.networkmanager.wifi.powersave = true;

  #---------------------------------------------------------------------
  # Enable power management (do not disable this unless you have a reason to).
  # Likely to cause problems on laptops and with screen tearing if disabled.
  #---------------------------------------------------------------------
  powerManagement = {
    enable = true;
    powertop.enable = mkForce true;
    # powertop.enable = mkForce true;
  };

  # Allow brightness control by video group.
  hardware.acpilight.enable = true;

  #---------------------------------------------------------------------
  # Enable TLP for better power management with Schedutil governor
  #---------------------------------------------------------------------    
  services.tlp = {
    enable = true; # Enable the TLP power management tool
    settings = {
      DISK_DEVICES = "nvme0n1 nvme1n1 sda sdb"; # Specify disk devices to manage
      TLP_DEFAULT_MODE = "BAT";                 # according to TLP documentation

      # CPU settings
      CPU_SCALING_GOVERNOR_ON_AC = "schedutil";   # Adjust as needed
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";  # Adjust as needed
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      #CPU_SCALING_MAX_FREQ_ON_BAT = "1700000";
      #CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      WIFI_PWR_ON_AC = "on";
      WIFI_PWR_ON_BAT = "on";

      PLATFORM_PROFILE_ON_BAT = "low-power";
      PLATFORM_PROFILE_ON_AC = "balanced";

      # SATA power management
      AHCI_RUNTIME_PM_ON_AC = "auto";   # Enable runtime power management for SATA disks when on AC power
      AHCI_RUNTIME_PM_ON_BAT = "auto"; # Enable automatic runtime power management for SATA disks when on battery power

      # PCIe runtime power management
      RUNTIME_PM_ON_AC = "on";    # Enable runtime power management for PCIe devices when on AC power
      RUNTIME_PM_ON_BAT = "auto"; # Enable automatic runtime power management for PCIe devices when on battery power

      # ACPI settings
      NATACPI_ENABLE = 1; # Enable ACPI calls for battery status and charge thresholds (1 = enabled)

      # Sound power saving
      SOUND_POWER_SAVE_ON_AC = 0;   # Disable power saving for sound devices when on AC power (0 = disabled)
      SOUND_POWER_SAVE_ON_BAT = 1;  # Enable power saving for sound devices when on battery power (1 = enabled)

      # ThinkPad specific settings
      TPACPI_ENABLE = 1;  # Enable ThinkPad-specific ACPI features (1 = enabled)
      TPSMAPI_ENABLE = 1; # Enable ThinkPad-specific battery management via tp-smapi (1 = enabled)

      # USB autosuspend
      USB_AUTOSUSPEND = 1;

      # Wake-on-LAN
      WOL_DISABLE = "Y"; # Disable Wake-on-LAN (Y = disabled)

      # Battery charge thresholds
      START_CHARGE_THRESH_BAT0 = "35";
      STOP_CHARGE_THRESH_BAT0 = "81";
    };
  };
}
