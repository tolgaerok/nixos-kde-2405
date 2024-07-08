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
    # Include the results of the hardware scan.
    # ./core/variables
    ./DE/gnome46.nix
    ./cachix.nix
    ./core/boot/efi/efi.nix
    ./core/gpu/nvidia/nvidia-stable-opengl # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
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
    firefox.enable = true;
    gnupg.agent.enable = true; # Enable the GnuPG agent service for managing GPG keys.
    mtr.enable = true; # Enable the MTR (My Traceroute) network diagnostic tool.

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
  # Ozone-Wayland backend when running in a Wayland session. 
  # This improves performance and compatibility, making your experience 
  # smoother and more integrated with the Wayland compositor you are using.
  #---------------------------------------------------------------------

  ###---------- Intel / Nvidia session ----------###
  environment.variables = {
    # Wayland-related settings (commented out)
    
    # CLUTTER_BACKEND = "wayland";            # Specifies Wayland as the backend for Clutter.
    # GDK_BACKEND = "x11";                       # Specifies X11 as the backend for GDK.
    # LIBGL_ALWAYS_SOFTWARE = "1";               # Forces the use of software rendering for OpenGL.
    # LIBVA_DRIVER_NAME = "i965";             # Force Intel i965 driver.
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1"; # Disables window decorations in Qt applications when using Wayland.
    # SDL_VIDEODRIVER = "wayland";            # Sets the video driver for SDL applications to Wayland.
    # X11-related settings
    # XDG_CURRENT_DESKTOP = "wayland";        # Sets the current desktop environment to Wayland.
    # XDG_SESSION_CLASS = "user";                # Sets the session class to 'user'.
    # XDG_SESSION_TYPE = "wayland";           # Defines the session type as Wayland.
    # XDG_SESSION_TYPE = "x11";                  # Defines the session type as X11.
    # __GLX_VENDOR_LIBRARY_NAME = "mesa";     # Specifies the GLX vendor library to use, ensuring Mesa's library is used.

    MOZ_ENABLE_WAYLAND = "1";                  # Enables Wayland support in Mozilla applications (e.g., Firefox).
    NIXOS_OZONE_WL = "1";                      # Enables the Ozone Wayland backend for Chromium-based browsers.
    NIXPKGS_ALLOW_UNFREE = "1";                # Allows the installation of packages with unfree licenses in Nixpkgs.
    TOLGAOS = "true";
    TOLGAOS_VERSION = "2.2";
  };  
  
  #---------------------------------------------------------------------
  # Networking
  #---------------------------------------------------------------------
  networking = {
    networkmanager = {
      enable = true;      
    };
    hostName = "${hostname}"; # Set the hostname for the system.
    firewall.allowedTCPPorts = [ 22 ]; # Allow incoming TCP traffic on port 22 (SSH).
  };

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
      homeMode = "755";
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
        acpi
        bcachefs-tools
        clementine
        cpufrequtils
        cpupower-gui
        direnv
        duf
        ethtool
        firefox
        flameshot
        fortune
        gimp-with-plugins
        git
        git-up
        gnome-extension-manager
        gnome-usage
        gnome.dconf-editor
        gnome.file-roller
        gnome.gnome-disk-utility
        gnome.gnome-software
        gnome.gnome-tweaks
        gnome.gvfs
        gnome.rygel
        gnome.simple-scan
        gnomeExtensions.appindicator
        gnomeExtensions.dash-to-dock
        gnomeExtensions.just-perfection
        gnomeExtensions.logo-menu
        gnomeExtensions.wifi-qrcode
        gnomeExtensions.wireless-hid
        google-chrome
        gupnp-tools # UPNP tools USAGE: gupnp-universal-cp
        kate
        kdePackages.kate
        kdePackages.spectacle
        keyutils
        libnotify
        libsForQt5.qt5.qtgraphicaleffects
        libsForQt5.qt5.qtquickcontrols2
        libsForQt5.spectacle
        libwps
        lm_sensors
        lolcat
        megasync
        mesa
        mpv
        neofetch
        nix-prefetch-git
        nixfmt-rfc-style
        notify
        notify-desktop
        polkit
        polkit_gnome        
        powerstat
        powertop
        sutils
        tlp
        unrar
        unzip
        variety
        vscode
        vscode-extensions.brettm12345.nixfmt-vscode
        wpsoffice
        zstd   

        # Make sure that every character can be displayed by adding this font
        noto-fonts 
        # qt recommends this system package for wayland
        qt6.qtwayland  
        xorg.libxcb # required for steam according to some people, but steam worked without it too 
        # automount
        udiskie
      ];

      openssh = {
        authorizedKeys = {
          keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGg5V+YAm36cZcZBZz1fv7+0kP05DpoGs1EhcrlI09i kingtolga@gmail.com"
          ];
          keyFiles = [ /home/${name}/.ssh/id_ed25519.pub ];
        };
      };
    };
  };

  #---------------------------------------------------------------------
  # Audio settings
  #---------------------------------------------------------------------

  # Enable sound with pipewire.
  sound.enable = true;  

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
