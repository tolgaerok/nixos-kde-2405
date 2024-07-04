{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
# with builtins;
let
in
# cfg = config.sys.desktop;
{

  # -----------------------------------------------
  # X11 settings
  # -----------------------------------------------

  # Enable the X11 windowing system and keymap.
  services = {
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

      desktopManager.gnome.enable = true; # Enable GNOME as the desktop manager.

      xkb = {
        layout = "au"; # Set the keyboard layout to "au" (Australia).
        variant = ""; # No specific keyboard variant.
      };
    };

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

  xdg.portal = {
    enable = true; # Enable xdg portals for desktop integration.

    wlr.enable = true; # Enable Wayland Remote Protocol.

    xdgOpenUsePortal = true; # Use xdg portals for opening files.

    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr # Extra portal for Wayland desktop integration.
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
