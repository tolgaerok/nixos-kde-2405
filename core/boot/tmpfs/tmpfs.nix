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
}
