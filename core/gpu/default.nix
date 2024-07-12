{ config, lib, ... }:

# Determine if the system has an NVIDIA or Intel GPU
with lib;

let
  isIntelSystem = builtins.pathExists "/sys/bus/pci/devices/0000:00:02.0/vendor";
  isNvidiaSystem = builtins.pathExists "/proc/driver/nvidia/version";

  # Choose GPU configuration
  gpuConfig =
    if isIntelSystem then
      # Intel with hardware acceleration (Open-GL) 
      ./intel
    else if isNvidiaSystem then
      # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
      ./nvidia
    else
      # ERROR
      ./no-gpu-found.nix;
in
{
  imports = [
    # Call custom Modules
    gpuConfig
  ];
}