# Tolga Erok
# Tue Jul 2, 2024
# My personal NIXOS KDE configuration ..
# 
#              ¯\_(ツ)_/¯
#   ███▄    █     ██▓   ▒██   ██▒    ▒█████       ██████ 
#   ██ ▀█   █    ▓██▒   ▒▒ █ █ ▒░   ▒██▒  ██▒   ▒██    ▒ 
#  ▓██  ▀█ ██▒   ▒██▒   ░░  █   ░   ▒██░  ██▒   ░ ▓██▄   
#  ▓██▒  ▐▌██▒   ░██░    ░ █ █ ▒    ▒██   ██░     ▒   ██▒
#  ▒██░   ▓██░   ░██░   ▒██▒ ▒██▒   ░ ████▓▒░   ▒██████▒▒
#  ░ ▒░   ▒ ▒    ░▓     ▒▒ ░ ░▓ ░   ░ ▒░▒░▒░    ▒ ▒▓▒ ▒ ░
#  ░ ░░   ░ ▒░    ▒ ░   ░░   ░▒ ░     ░ ▒ ▒░    ░ ░▒  ░ ░
#     ░   ░ ░     ▒ ░    ░    ░     ░ ░ ░ ▒     ░  ░  ░  
#           ░     ░      ░    ░         ░ ░           ░  
#  
#------------------ HP EliteDesk 800 G1 SFF ------------------------

# BLUE-TOOTH        REALTEK 5G
# CPU	              Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz x 8 (Haswell)
# i-GPU	            Integrated Intel HD Graphics
# d-GPU	            NVIDIA GeForce GT 1030/PCIe/SSE2
# MODEL             HP EliteDesk 800 G1 SFF
# MOTHERBOARD	      Intel® Q87 Express
# NETWORK	          Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz
# RAM	              28 GB DDR3, 1600-MHz DDR3 SDRAM, Max 32
# STORAGE           SAMSUNG SSD 870 EVO 500GB
# EXPENSION SLOTS   (2) PCI Express x1 (v2.0), (1) PCI Express x 16 (v2.0 - wired as x4)
#                   (1) PCI Express x16 (v3.0), (1) Optional PCI (v2.3)
# PSU               320W
# CERTIFIED         RHEL, SUSE ENTERPRISE, WINDOWS 7 - 10 (Can run hacked W11 ent)
# SOURCE            https://support.hp.com/au-en/document/c03832938

#---------------------------------------------------------------------

{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

let
  # Inherit varibles
  inherit (import ./core/variables) gitEmail gitUsername name country hostname locale;

  # Kernel options
  latest-std-kernel = pkgs.linuxPackages_latest;
  latest-xanmod-kernel = pkgs.linuxPackages_xanmod_latest;
  zen-std-kernel = pkgs.linuxPackages_zen;   
in
{
  imports = [    
    # ./core/variables    

    ./desktop-env/dsk_gnome.nix
    ./cachix.nix
    ./core/boot/efi/efi.nix
    ./core/environment
    ./core/gpu
    ./core/modules
    ./core/packages
    ./core/programs
    ./core/security
    ./core/services/services.nix
    ./core/system
    ./hardware-configuration.nix
    ./network
  ]; 

  #---------------------------------------------------------------------
  # Custom kernel selection from user
  #---------------------------------------------------------------------
  boot.kernelPackages = latest-std-kernel;

  # Enable UPNP for gupnp-tools # UPNP tools USAGE: gupnp-universal-cp
  programs = {    
    git = {
      enable = true;
      config = {
        user.name = "${gitUsername}";
        user.email = "${gitEmail}";
      };
    };    
    ssh.startAgent = true; # Enable the SSH agent for managing SSH keys.
  };
  
  #---------------------------------------------------------------------
  # Networking
  #---------------------------------------------------------------------
  networking.hostName = "${hostname}";  

  # -----------------------------------------------
  # Locale settings
  # -----------------------------------------------

  # Set your time zone.
  time.timeZone = "${country}";

  # Select internationalisation properties.
  i18n.defaultLocale = "${locale}";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${locale}";
    LC_IDENTIFICATION = "${locale}";
    LC_MEASUREMENT = "${locale}";
    LC_MONETARY = "${locale}";
    LC_NAME = "${locale}";
    LC_NUMERIC = "${locale}";
    LC_PAPER = "${locale}";
    LC_TELEPHONE = "${locale}";
    LC_TIME = "${locale}";
  };

  #---------------------------------------------------------------------
  # User account settings
  #---------------------------------------------------------------------
  users = {
    mutableUsers = true;

    groups.${name} = {
      members = [ ];
    };

    extraUsers.${name} = {
      name = "${name}";
      group = "${name}";
    };

    users."${name}" = {      
      isNormalUser = true;
      description = "${name}";
      extraGroups = [
        "${name}"
        "adbusers"
        "audio"
        "code"
        "corectrl"
        "disk"
        "docker"
        "input"
        "libvirtd"
        "lp"
        "minidlna"
        "mongodb"
        "mysql"
        "network"
        "networkmanager"
        "postgres"
        "power"
        "samba"
        "scanner"
        "smb"
        "sound"
        "storage"
        "systemd-journal"
        "udev"
        "users"
        "video"
        "wheel" # Enable ‘sudo’ for the user.
      ];

      packages = with pkgs; [ 
        ### Utilities
        acpi
        bcachefs-tools
        direnv
        duf
        ethtool
        fortune
        git
        git-up
        keyutils
        libnotify
        lm_sensors
        neofetch
        nix-prefetch-git
        nixfmt-rfc-style
        notify
        notify-desktop
        powerstat
        powertop
        sutils
        tlp
        unrar
        unzip
        zstd

        ### Applications
        clementine
        cpufrequtils
        cpupower-gui
        firefox
        flameshot
        gimp-with-plugins
        google-chrome
        gupnp-tools
        kate
        kdePackages.kate
        kdePackages.spectacle
        libwps
        lolcat
        megasync
        mp3fs
        mpv
        polkit
        polkit_gnome
        variety
        vscode
        vscode-extensions.brettm12345.nixfmt-vscode
        wpsoffice

        ### Libraries
        libsForQt5.qt5.qtgraphicaleffects
        libsForQt5.qt5.qtquickcontrols2
        libsForQt5.spectacle
        mesa

        ### Fonts
        noto-fonts

        ### System Packages
        qt6.qtwayland
        xorg.libxcb
        udiskie

      ];

      openssh = {
        authorizedKeys = {
          keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGg5V+YAm36cZcZBZz1fv7+0kP05DpoGs1EhcrlI09i kingtolga@gmail.com"
            # NEW -> Jul 12 2024   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgYpmkzd4gwbnFo25VQcGp1rGiYtYjRv3RvETD0nAz/"
          ];
          # keyFiles = [ /home/${name}/.ssh/id_ed25519.pub ];
        };
      };
    };
  };

  #---------------------------------------------------------------------
  # Automatic system upgrades, automatically reboot after an upgrade if
  # necessary
  #---------------------------------------------------------------------
  system = {
    autoUpgrade.allowReboot = false; # Prevent automatic reboots after system upgrades.
    autoUpgrade.enable = true; # Enable automatic system upgrades.
    copySystemConfiguration = true; # Copy the current system configuration to /etc/nixos after rebuilds.
    stateVersion = "24.05"; # Specify the NixOS release version to maintain compatibility.
  };
}
