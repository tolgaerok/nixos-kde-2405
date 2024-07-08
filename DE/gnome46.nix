{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with builtins;
let
in
# cfg = config.sys.desktop;
{

  # -----------------------------------------------
  # X11 settings
  # -----------------------------------------------

  # Enable the X11 windowing system and keymap.
  services = {
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    ipp-usb.enable = true;
    smartd = {
      enable = true;
      autodetect = true;
    };

    # Enable the X11 windowing system.
    xserver = {
      enable = true; # Enable the X11 windowing system.
      displayManager.gdm = {
        enable = true; # Enable GDM as the display manager.
        wayland = true; # Enable Wayland support for GDM.
        settings = {
          daemon = {
            wayland = true; # Enable Wayland in GDM daemon settings.
          };
        };
      };
      videoDrivers = [ "nvidia" ]; # Use Nvidia drivers for video.
      deviceSection = ''
        Option "Coolbits" "12"
        Option "TripleBuffer" "True"
        Option "NoLogo" "True"
        Option "UseNvKmsCompositionPipeline" "True"
        Option "UseEDIDFreqs" "True"
      '';
      desktopManager.gnome.enable = true; # Enable GNOME as the desktop manager.
      xkb = {
        layout = "au"; # Set the keyboard layout to "au" (Australia).
        variant = ""; # No specific keyboard variant.
      };
    };
    # Enable libinput.
    libinput = {
      enable = true; # Enable libinput for input handling.

      touchpad = {
        disableWhileTyping = true; # Disable touchpad while typing.
        naturalScrolling = true; # Enable natural scrolling direction.
      };
    };
    dbus.enable = true; # Enable D-Bus for inter-process communication.
  };
  hardware = {
    opengl = {
      enable = true; # Enable OpenGL support.
    };
  };
  programs = {
    xwayland = {
      enable = true; # Enable XWayland for X11 compatibility.
    };
  };
  # Enable and configure xdg portals.
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      # pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };
}

# ORIGINAL
# Enable the GNOME Desktop Environment.
# services = {
#  xserver = {
#    # Enable the X11 windowing system.
#    enable = true;
#    displayManager.gdm.enable = true;
#    desktopManager.gnome.enable = true;

# Configure keymap in X11
#    xkb.layout = "au";
#    xkb.variant = "";
#  };
# };
