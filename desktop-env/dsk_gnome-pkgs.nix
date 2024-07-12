{
  config,
  pkgs,
  lib,
  ...
}:

### Gnome desktop packages

{

  environment.systemPackages = with pkgs; [

    ### GNOME Extensions
    gnomeExtensions.open-bar
    gnomeExtensions.appindicator
    gnomeExtensions.compiz-alike-magic-lamp-effect
    gnomeExtensions.compiz-windows-effect
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.logo-menu
    gnomeExtensions.transparent-window-moving
    gnomeExtensions.wifi-qrcode
    gnomeExtensions.wireless-hid

    ### GNOME Applications
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
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}
