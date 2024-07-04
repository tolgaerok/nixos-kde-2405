<<<<<<< HEAD
{ config, lib, ... }:

with lib;

{
  # silence ACPI "errors" at boot shown before NixOS stage 1 output (default is 4)
  boot.consoleLogLevel = 3;

  # tmpfs (a filesystem stored in RAM) settings for the NixOS boot process.
  # Clean tmpfs on system boot, useful for ensuring a clean state.
  # NOTE:  boot.tmp can not be nested, must stay as toplevel as they are part of the global system configuration
  boot.tmp.cleanOnBoot = true;

  # Enable tmpfs for the specified directories.
  boot.tmp.useTmpfs = true;

  # NEW: set to auto to dynamically grow    OLD:Allocate 35% of RAM for tmpfs. You can adjust this percentage to your needs.
  boot.tmp.tmpfsSize = "35%";

  fileSystems."/run" = {
    device = "tmpfs";
    options = [ "size=5G" ]; # Adjust based on your preferences and needs
  };

  # Fixed : better to use Dynamic 
   fileSystems."/tmp" = {
    device = "tmpfs";
    options = [ "size=5G" ];  # Adjust based on your preferences and needs
   };  

}

=======
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
with lib;
let
  name = "tolga";
in
{
  # Silence ACPI "errors" at boot shown before NixOS stage 1 output (default is 4)
  boot.consoleLogLevel = 3;

  # Clean tmpfs on system boot, useful for ensuring a clean state
  boot.tmp.cleanOnBoot = true;

  # Enable tmpfs for the specified directories
  boot.tmp.useTmpfs = true;

  # Adjust tmpfs size based on system RAM
  boot.tmp.tmpfsSize = "30%"; # 30% for 27GB system - else "25%"; # 25% for 8GB system

  # Set up tmpfs for /run with a fixed size
  fileSystems."/run" = {
    device = "tmpfs";
    options = [ "size=6G" ];
  };

  # Set up tmpfs for /tmp with a fixed size
  fileSystems."/tmp" = {
    device = "tmpfs";
    options = [ "size=7G" ];
  };

  # Add a file system entry for the "DLNA" directory bind mount
  fileSystems."/mnt/DLNA" = {
    device = "/home/${name}/DLNA/";
    fsType = "none";
    options = [
      "rw"
      "bind"
    ];
  };

  # Add a file system entry for the "Gimp" bind mount
  fileSystems."/mnt/GIMP" = {
    device = "/home/${name}/Pictures/CUSTOM-WALLPAPERS/";
    fsType = "none";
    options = [
      "rw"
      "bind"
    ];
  };

  # Add a file system entry for the "MyGit" directory bind mount
  fileSystems."/mnt/MyGit" = {
    device = "/home/${name}/MyGit/";
    fsType = "none";
    options = [
      "rw"
      "bind"
    ];
  };
}
>>>>>>> 0fce02f ((ツ)_/¯ Edit: 03-07-2024 11:52:51 PM)
