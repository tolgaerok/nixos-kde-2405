{ config, lib, ... }:
let
in
{
  boot.kernelParams = [
    "nvidia-drm.modeset=1"                          # Enable kernel modesetting for NVIDIA graphics
    "nvidia.NVreg_EnablePCIeGen3=1"                 # Enable PCIe Gen3 for NVIDIA
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1" # Preserve video memory allocations across suspend/resume
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"       # Set temporary file path for NVIDIA driver
    "nvidia.NVreg_UsePageAttributeTable=1"          # Enable NVIDIA Page Attribute Table
    "video.allow_duplicates=1"                      # Allow duplicate frames or similar, helps smooth video playback
    "AllowFlipping=Off"
  ];
}
