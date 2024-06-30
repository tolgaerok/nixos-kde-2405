# Tolga Erok
# 10/6/2023
# My personal NIXOS KDE configuration
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
  username,
  ...
}:

with lib;

let
  latest-std-kernel = pkgs.linuxPackages_latest;
  latest-xanmod-kernel = pkgs.linuxPackages_xanmod_latest;
  zen-std-kernel = pkgs.linuxPackages_zen;

  country = "Australia/Perth";
  hostname = "G1800-Nixos";
  locale = "en_AU.UTF-8";
  name = "tolga";
in

{
  imports = [

    ./cachix.nix
    ./core/boot/efi/efi.nix
    ./core/gpu/nvidia/nvidia-stable-opengl # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ./core/modules
    ./core/packages
    ./core/programs
    ./core/services/services.nix
    ./core/system
    ./hardware-configuration.nix
    ./network
  ];

  #---------------------------------------------------------------------
  # Custom kernel selection from user
  #---------------------------------------------------------------------
  boot.kernelPackages = latest-std-kernel;

  # -----------------------------------------------
  # Enables simultaneous use of processor threads.
  # -----------------------------------------------
  security = {
    allowSimultaneousMultithreading = true; # Allow simultaneous multithreading (SMT).
    rtkit.enable = true; # Enable RealtimeKit (rtkit) for managing real-time priorities.
  };

  ###---------- Nvidia session ----------###
  environment.variables = {
    # XDG_CURRENT_DESKTOP = "wayland";      # Sets the current desktop environment to Wayland.
    # XDG_SESSION_TYPE = "wayland";         # Defines the session type as Wayland.
    CLUTTER_BACKEND = "wayland";                # Specifies Wayland as the backend for Clutter.
    LIBVA_DRIVER_NAME = "nvidia";                   
    MOZ_ENABLE_WAYLAND = "1";                   # Enables Wayland support in Mozilla applications (e.g., Firefox).
    NIXOS_OZONE_WL = "1";                       # Enables the Ozone Wayland backend for Chromium-based browsers.
    NIXPKGS_ALLOW_UNFREE = "1";                 # Allows the installation of packages with unfree licenses in Nixpkgs.
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";  # Disables window decorations in Qt applications when using Wayland.
    SDL_VIDEODRIVER = "wayland";                # Sets the video driver for SDL applications to Wayland.
    WLR_NO_HARDWARE_CURSORS = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";       # Specifies the GLX vendor library to use, ensuring Mesa's library is used    
    __GL_SHADER_CACHE = "1";
    __GL_THREADED_OPTIMIZATION = "1";
  };

  #---------------------------------------------------------------------
  # Networking
  #---------------------------------------------------------------------
  networking = {
    networkmanager = {
      enable = true;
      # wifi.powersave = true; # Enable power-saving mode for Wi-Fi.
      connectionConfig = {
        "ethernet.mtu" = 1462; # Set MTU for Ethernet connections.
        "wifi.mtu" = 1462; # Set MTU for Wi-Fi connections.
      };
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

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;

      # Configure keymap in X11
      xkb.layout = "au";
      xkb.variant = "";
    };

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable Pipewire with ALSA and PulseAudio support.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  #---------------------------------------------------------------------
  # User account settings
  #---------------------------------------------------------------------
  users = {
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
        "code"
      ];

      packages = with pkgs; [
        # Internet related
        # brave
        firefox
        google-chrome

        # Personal
        acpi
        bcachefs-tools
        clementine
        duf
        ethtool
        flameshot
        fortune
        gimp-with-plugins
        git
        git-up
        gnome.gvfs
        gnome.rygel
        gupnp-tools # UPNP tools USAGE: gupnp-universal-cp
        kate
        keyutils
        libnotify
        libwps
        lolcat
        mesa
        neofetch
        nix-prefetch-git
        notify
        notify-desktop
        variety
        wpsoffice
        zstd

        kdePackages.kate

        # Development
        direnv
        nixfmt-rfc-style
        vscode
        vscode-extensions.brettm12345.nixfmt-vscode

        # MegaSync related
        megasync

        # Extra laptop packages
        acpi
        cpufrequtils
        cpupower-gui
        ethtool
        powerstat
        powertop
        sutils
        tlp
      ];

      openssh = {
        authorizedKeys = {
          keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGg5V+YAm36cZcZBZz1fv7+0kP05DpoGs1EhcrlI09i kingtolga@gmail.com"
          ];
          keyFiles = [
            /home/${name}/.ssh/id_ed25519.pub
          ];
        };
      };
    };
  };

  # Enable UPNP for gupnp-tools # UPNP tools USAGE: gupnp-universal-cp
  programs = {
    gnupg.agent.enable = true; # Enable the GnuPG agent service for managing GPG keys.
    mtr.enable = true; # Enable the MTR (My Traceroute) network diagnostic tool.
    ssh.startAgent = true; # Enable the SSH agent for managing SSH keys.
    firefox.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
