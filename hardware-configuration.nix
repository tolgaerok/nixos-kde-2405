# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
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
  extraBackends = [ pkgs.epkowa ];
in

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    blacklistedKernelModules = lib.mkDefault [ "nouveau" ];    

    kernelModules = [
      "kvm-intel"     # KVM on Intel CPUs
      "coretemp"      # Temperature monitoring on Intel CPUs
      "fuse"          # userspace filesystem framework.
      "i2c-dev"       # An acronym for the “Inter-IC” bus, a simple bus protocol which is widely used where low data rate communications suffice.
      "i2c-piix4"
      "nvidia"
      "tcp_bbr"       # BBR: Dynamically optimize how data is sent over a network, aiming for higher throughput and reduced latency
      "tcp_cubic"     # Cubic: A traditional and widely used congestion control algorithm
      "tcp_westwood"  # Westwood: Particularly effective in wireless networks
      #"intel_idle"
      #"tcp_newreno"   # New Reno: An extension of the Reno algorithm with some improvements
      #"tcp_reno"      # Reno: Another widely used and stable algorithm
    ];

    # intel_idle.max_cstate=0
    extraModprobeConfig = ''      
    '';

    kernel.sysctl = {
      # Kernel Settings
      "kernel.pty.max" = 24000;                        # Maximum number of pseudo-terminal (pty) devices.
      "kernel.sched_autogroup_enabled" = 0;            # Disable automatic grouping of tasks in the scheduler.
      "kernel.sched_migration_cost_ns" = 5000000;      # Cost (in nanoseconds) of migrating a task to another CPU.
      "kernel.sysrq" = 1;                              # Enable the SysRq key for low-level system commands.
      "kernel.pid_max" = 131072;                       # Maximum number of processes and threads.

      # Network Settings
      # "net.core.default_qdisc" = "fq";                 # Use Fair Queueing (FQ) as default queuing discipline for reduced latency.
      "net.core.default_qdisc" = "cake";
      "net.core.netdev_max_backlog" = 30000;           # Helps prevent packet loss during high traffic periods.
      "net.core.rmem_default" = 4194304;               # Default socket receive buffer size increased for better network performance.
      "net.core.rmem_max" = 16777216;                  # Maximum socket receive buffer size increased for better network performance.
      "net.core.wmem_default" = 4194304;               # Default socket send buffer size increased for better network performance.
      "net.core.wmem_max" = 16777216;                  # Maximum socket send buffer size increased for better network performance.
      "net.ipv4.ipfrag_high_threshold" = 5242880;      # Threshold to reduce fragmentation.
      "net.ipv4.tcp_congestion_control" = "bbr";       # Use TCP BBR congestion control algorithm for optimized throughput.
      "net.ipv4.tcp_keepalive_intvl" = 15;             # TCP keepalive interval in seconds for faster detection of connection issues.
      "net.ipv4.tcp_keepalive_probes" = 3;             # TCP keepalive probes for faster detection of connection issues.
      "net.ipv4.tcp_keepalive_time" = 120;             # TCP keepalive interval in seconds for faster detection of connection issues.

      # Virtual Memory Settings
      "vm.dirty_background_bytes" = 67108864;          # Reduce dirty background bytes to 64 MB for faster writeback initiation.
      "vm.dirty_bytes" = 268435456;                    # Increase dirty bytes to 256 MB for more efficient dirty memory handling.
      "vm.dirty_background_ratio" = 5;                 # Set very low dirty background ratio to trigger faster writeback (5%).
      "vm.dirty_expire_centisecs" = 1000;              # Decrease dirty expire centiseconds to 10 seconds for faster writeout.
      "vm.dirty_ratio" = 30;                           # Lower dirty ratio to 30% for faster process writeout.
      "vm.dirty_time" = 1;                             # Enable dirty time accounting to track dirty page age.
      "vm.dirty_writeback_centisecs" = 100;            # Reduce dirty writeback centiseconds to 1 second for faster background writeback.
      "vm.max_map_count" = 1000000;                    # Maximum number of memory map areas per process.
      "vm.min_free_kbytes" = 131072;                   # Minimum free memory for safety (in KB).
      "vm.swappiness" = 10;                            # Kernel tendency to swap inactive memory pages.
      "vm.vfs_cache_pressure" = 90;                    # Management of memory used for caching filesystem objects.

      # File System Settings
      "fs.aio-max-nr" = 524288;                        # Increase maximum number of asynchronous I/O requests for faster file I/O.
      "fs.inotify.max_user_watches" = 1048576;         # Increase maximum number of file system watches for better file system monitoring.

      # Nobara Tweaks
      "kernel.panic" = 5;                              # Reboot after 5 seconds on kernel panic.
    };

    kernelParams = [
      "pcie_aspm=off"
      "zswap.enabled=1"
      "elevator=kyber"              # Change IO scheduler to Kyber
      "fbcon=nodefer"               # prevent the kernel from blanking plymouth out of the fb
      "intel_iommu=on"              # Enable IOMMU
      "io_delay=none"               # Disable I/O delay accounting
      "iomem=relaxed"               # Allow more relaxed I/O memory access
      "iommu=pt"                    # Enables passthrough mode for the IOMMU, allowing direct access to hardware devices.
      "irqaffinity=0-7"             # Set IRQ affinity to CPUs 0-3 (Intel Core i7-3667U specific)
      "loglevel=3"                  # Set kernel log level to 3 (default)
      "logo.nologo"                 # disable boot logo if any
      "mitigations=off"             # turns off certain CPU security mitigations. It might enhance performance
      "noirqdebug"                  # Disable IRQ debugging
      "nvidia_drm.fbdev=1"          # Enables the use of a framebuffer device for NVIDIA graphics. This can be useful for certain configurations.
      "nvidia_drm.modeset=1"        # Enables kernel modesetting for NVIDIA graphics. This is essential for proper graphics support on NVIDIA GPUs.
      "pti=off"                     # Disable Kernel Page Table Isolation (PTI)
      "quiet"                       # suppresses most boot messages during the system startup
      "rd.systemd.show_status=false" # Disable systemd boot status display
      "rd.udev.log_level=3"         # lower the udev log level to show only errors or worse
      "rootdelay=0"                 # No delay when mounting root filesystem
      "splash"                      # Enable graphical boot splash screen
      "threadirqs"                  # Enable threaded interrupt handling
      "udev.log_level=3"            # Sets the overall udev log level to 3, displaying informational messages.
      "video.allow_duplicates=1"    # allows duplicate frames or similar, help smoothen video playback, especially on systems that struggle with rendering every single frame due to hardware limitations.
      "vt.global_cursor_default=0"  # Disable blinking cursor in text mode
      "nmi_watchdog=0"
      # "intel_pstate=disable"          # Disabling the Intel P-state driver, which manages the CPU frequency scaling in some Intel processors
      # "isolcpus=0-7"                  # isolates CPUs 1 to 7 from the general system scheduler, often used for dedicated processing to prevent interference from unrelated tasks
      # "nohz_full=0-7"                 # isolates CPUs 1 to 7 from the tickless idle scheduler, which could potentially improve performance on those cores by reducing interruptions from timer ticks
      # "rcu_nocbs=0-7"                 # designates CPUs 1 to 7 for RCU (Read-Copy Update) processing, isolating them from other system tasks to enhance performance
      # "rd.systemd.show_status=auto"   # disable systemd status messages
      # "systemd.show_status=auto"      # Commented out, not used in this configuration
    ];

    initrd.kernelModules = [
      "cifs"          #  implementation of the Server Message Block (SMB) protocol, is used to share file systems, printers, or serial ports over a network.
      # "nvidia"
      # "dm-snapshot" #  a read-only copy of the entire file system and all the files contained in the file system.
    ];

    initrd.availableKernelModules = [
      "ahci"        # Enables the Advanced Host Controller Interface (AHCI) driver, typically used for SATA (Serial ATA) controllers.
      "ehci_pci"    # Enables the Enhanced Host Controller Interface (EHCI) driver for PCI-based USB controllers, providing support for USB 2.0.
      "nvidia"      # Enables the Nvidia driver module.
      "nvme"        # module in your initrd configuration can be useful if you plan to use an NVMe drive in the future
      "sd_mod"      # Enables the SCSI disk module (sd_mod), which allows the system to recognize and interact with SCSI-based storage devices.
      "sr_mod"      # Loads the SCSI (Small Computer System Interface) CD/DVD-ROM driver, allowing the system to recognize and use optical drives.
      "uas"         # Enables the USB Attached SCSI (UAS) driver, which provides a faster and more efficient way to access USB storage devices.
      "usb_storage" # Enables the USB Mass Storage driver, allowing the system to recognize and use USB storage devices like USB flash drives and external hard drives.
      "usbhid"      # Enables the USB Human Interface Device (HID) driver, which provides support for USB input devices such as keyboards and mice.
      "virtio_blk"  # Another Virtio module, enabling high-performance communication between the host and virtualized block devices (e.g., hard drives) in a virtualized environment.
      "virtio_pci"  # Part of Virtio virtualization standard, it supports efficient communication between the host and virtual machines with PCI bus devices.
      "xhci_pci"    # Enables the eXtensible Host Controller Interface (xHCI) driver for PCI-based USB controllers, providing support for USB 3.0 and later standards.
    ];

    extraModulePackages = with config.boot.kernelPackages; [ ];
    supportedFilesystems = ["ntfs" "ntfs3"];    # Enable support for NTFS and NTFS3 filesystems.
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c9cff38c-35a9-4a1a-9762-b052263a3183";
      fsType = "ext4";

    # Optimize SSD
    # ---------------------------------------------
    options = [
      "data=ordered"      # Ensures data ordering, improving file system reliability and performance by writing data to disk in a specific order.
      "defaults"          # Applies the default options for mounting, which usually include common settings for permissions, ownership, and read/write access.
      "discard"           # Enables the TRIM command, which allows the file system to notify the storage device of unused blocks, improving performance and longevity of solid-state drives (SSDs).
      "noatime"           # Disables updating access times for files, improving file system performance by reducing write operations.
      "nodiratime"        # Disables updating directory access time, improving file system performance by reducing unnecessary writes.
      "relatime"          # Updates the access time of files relative to the modification time, minimizing the performance impact compared to atime
    ];
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7D4E-CBD5";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "performance";
    
    #---------------------------------------------------------------------------
    # Disable hid driver (gyro/accel) while sleeping for extra power-saving
    #---------------------------------------------------------------------------

    # removes the intel_hid kernel module, which typically handles input from Intel HID devices, such as gyroscope and accelerometer sensors.
    #powerDownCommands = ''
    #  ${pkgs.kmod}/bin/modprobe -r intel_hid
    #'';
    # reloads the intel_hid kernel module, re-enabling the Intel HID devices.
    #resumeCommands = ''
    #  ${pkgs.kmod}/bin/modprobe intel_hid
    #'';
  };

  # Zswap requires a swapfile or partition to work correctly
  swapDevices = [{
    device = "/var/lib/swapfile";
    # Swap is used when your RAM is full. It shouldn't happen often, 
    # but you will be thankful that you have it when it is needed.

    # RAM size (27 GB) + 2 GB (since I have enough storage space)
    # I will use 8GB as Folio has 8GB - but a total of 10GB swap is more then enough
    size = (1024 * 8) + (1024 * 2); # RAM size + 2 GB (since I have enough storage space)
    priority = 10;
  }];

  networking = {
    useDHCP = lib.mkDefault true;
    # interfaces.enp0s25.useDHCP = lib.mkDefault true;
    # interfaces.wlo1.useDHCP = lib.mkDefault true;
  };

  # Allow unfree packages
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  #---------------------------------------------------------------------
  # Hardware Configuration
  #---------------------------------------------------------------------
  hardware = {
    # bluetooth.enable = false;
    bluetooth.powerOnBoot = false;    # Disable Bluetooth power on boot for power management and to analyze power consumption on Intel-based laptops.
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;  # Update Intel CPU microcode if redistributable firmware is enabled.
    enableAllFirmware = true;         # Enable all firmware.
    pulseaudio.enable = false;        # Disable PulseAudio.
    usb-modeswitch.enable = true;     # Enable USB Modeswitch to manage mobile broadband devices.
    logitech.wireless.enable = true;
    logitech.wireless.enableGraphical = true;

    sane = {
      enable = true;                 # Scanner and printing drivers
      extraBackends = extraBackends; # Scanner and printing drivers
    };
  };

  # Earlyoom killer
  systemd.oomd.enable = false;
  services.earlyoom.enable = true;
}
