{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ 
    ./miniDLNA.nix 
    ./cloudflare.nix
  ];

  # NetworkManager settings
  networking = {
    dhcpcd = {
      wait = "background";    # Configure dhcpcd to wait in the background for DHCP
      extraConfig = "noarp";  # Additional configuration for dhcpcd to disable ARP
    };

    # Enable NetworkManager
    networkmanager = {
      enable = true; 
      
      # Append Cloudflare and Google DNS servers
      appendNameservers = [
        "1.1.1.1"
        "8.8.8.8"
      ];

      # NextDns config
      #appendNameservers = [
        # "DNS=45.90.28.0#48b246.dns.nextdns.io"
        # "DNS=2a07:a8c0::#48b246.dns.nextdns.io"
        # "DNS=45.90.30.0#48b246.dns.nextdns.io"
        # "DNS=2a07:a8c1::#48b246.dns.nextdns.io"
        # "DNSOverTLS=yes"
      #];

      connectionConfig = {
        "ethernet.mtu" = 1500;  # Set MTU for ethernet connections
        "wifi.mtu" = 1500;      # Set MTU for WiFi connections
        "wifi.802-11-wireless.fragmentation-threshold" = 1500;  # Set fragmentation threshold for WiFi
        "wifi.802-11-wireless.rts-threshold" = 1000;            # Set RTS/CTS threshold for WiFi
      };
    };

    # Specify time servers for NTP synchronization
    timeServers = [ "pool.ntp.org" ];

    # Define extra hosts for the network
    extraHosts = ''
      127.0.0.1       localhost
      127.0.0.1       G1800-Nixos
      192.168.0.1     router
      192.168.0.2     DIGA            # Smart TV
      192.168.0.5     folio-F39       # HP Folio
      192.168.0.6     iPhone          # Dads mobile
      192.168.0.7     Laser           # Laser Printer
      192.168.0.8     min21THIN       # EMMC thinClient
      192.168.0.10    TUNCAY-W11-ENT  # Dads PC
      192.168.0.11    ubuntu-server   # CasaOS
      192.168.0.13    G1800-Nixos     # Main NixOS rig
      192.168.0.15    KingTolga       # My mobile
      192.168.0.20    W11-SERVER      # Main home server
      ::1             localhost ip6-localhost ip6-loopback
      fe00::0         ip6-localnet
      ff00::0         ip6-mcastprefix
      ff02::1         ip6-allnodes
      ff02::2         ip6-allrouters
      ff02::3         ip6-allhosts
    '';
  };

  environment.systemPackages = with pkgs; [
    ntp         # Network Time Protocol package for time synchronization
    gnome.rygel # GNOME Rygel package for media streaming
  ];

  # Enable GNOME Rygel service
  services = {
    gnome.rygel = {
      enable = true; 
      # friendly_name = "NixOS-Rygel";
    };
  };

  # Allow TCP port 8200 && 1900 through the firewall for rygel and miraclecast
  networking.firewall = {    
    allowedTCPPorts = [ 8200 22]; 
    allowedUDPPorts = [ 1900 ]; 
  };
  
  # Add MiracleCast package to D-Bus services
  services.dbus.packages = [ pkgs.miraclecast ]; 
}
