{ config, lib, ... }:

#---------------------------------------------------------------------
# Ozone-Wayland backend when running in a Wayland session. 
# This improves performance and compatibility, making your experience 
# smoother and more integrated with the Wayland compositor you are using.
#---------------------------------------------------------------------

###---------- Intel / Nvidia session ----------###

{
  environment.variables = {
    # Wayland-related settings (commented out)

    # CLUTTER_BACKEND = "wayland";            # Specifies Wayland as the backend for Clutter.
    # GDK_BACKEND = "x11";                       # Specifies X11 as the backend for GDK.
    # LIBGL_ALWAYS_SOFTWARE = "1";               # Forces the use of software rendering for OpenGL.
    # LIBVA_DRIVER_NAME = "i965";             # Force Intel i965 driver.
    # SDL_VIDEODRIVER = "wayland";            # Sets the video driver for SDL applications to Wayland.
    # X11-related settings
    # XDG_CURRENT_DESKTOP = "wayland";        # Sets the current desktop environment to Wayland.
    # XDG_SESSION_CLASS = "user";                # Sets the session class to 'user'.
    # XDG_SESSION_TYPE = "wayland";           # Defines the session type as Wayland.
    # XDG_SESSION_TYPE = "x11";                  # Defines the session type as X11.
    # __GLX_VENDOR_LIBRARY_NAME = "mesa";     # Specifies the GLX vendor library to use, ensuring Mesa's library is used.

    MOZ_ENABLE_WAYLAND = "1"; # Enables Wayland support in Mozilla applications (e.g., Firefox).
    NIXOS_OZONE_WL = "1"; # Enables the Ozone Wayland backend for Chromium-based browsers.
    NIXPKGS_ALLOW_UNFREE = "1"; # Allows the installation of packages with unfree licenses in Nixpkgs.
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1"; # Disables window decorations in Qt applications when using Wayland.
    TOLGAOS = "true";
    TOLGAOS_VERSION = "2.2";
  };
}
