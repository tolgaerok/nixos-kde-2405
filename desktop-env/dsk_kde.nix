{ config, pkgs, ... }:

{
  # KDE Configuration
  services = {
    displayManager = {
      # Enable SDDM display manager
      sddm.enable = true;
      # Enable autologin for user 'tolga'
      autoLogin.enable = true;
      autoLogin.user = "tolga";
      # Specify default session (not using Wayland)
      defaultSession = "plasmax11";
    };

    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      xkb = {
        layout = "au"; # Set the keyboard layout to "au" (Australia).
        variant = ""; # No specific keyboard variant.
      };

      desktopManager = {
        # Enable Plasma 6 desktop environment
        plasma6.enable = true;
        # plasma5.enable = true;  # Plasma 5 is disabled for now.
      };
    };

    security = {
      # pam_wallet will attempt to unlock the user's default KDE wallet upon login.
      # If the user has no kdewallet, or the login password does not match their wallet password,
      # KDE will prompt separately after login. sddm is the display manager.
      pam = {
        services = {
          sddm = {
            kwallet = {
              enable = true;
            };
          };
        };
      };
    };
  };

  environment = {
    plasma6 = {
      excludePackages = with pkgs.kdeApplications; [
        # Exclude okular and print-manager from Plasma 6
        # okular
        # print-manager
        gwenview
        khelpcenter
        oxygen
        plasma-browser-integration
      ];
    };
  };
}
