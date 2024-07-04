{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

{

  imports = [ ./vmguest.nix ];

  #---------------------------------------------------------------------
  # Install necessary packages
  #---------------------------------------------------------------------
  environment.systemPackages = with pkgs; [
<<<<<<< HEAD
    OVMFFull
=======
    # virtualbox
    OVMFFull
    bridge-utils
>>>>>>> 0fce02f ((ツ)_/¯ Edit: 03-07-2024 11:52:51 PM)
    gnome.adwaita-icon-theme
    kvmtool
    libvirt
    qemu
    spice
    spice-gtk
    spice-protocol
    spice-vdagent
    swtpm
<<<<<<< HEAD
    virt-manager
    virt-viewer
    # virtualbox
=======
    virglrenderer
    virt-manager
    virt-viewer
    virtiofsd
>>>>>>> 0fce02f ((ツ)_/¯ Edit: 03-07-2024 11:52:51 PM)
    win-spice
    win-virtio
  ];

  #---------------------------------------------------------------------
  # Manage the virtualisation services : Libvirt stuff
  #---------------------------------------------------------------------
  virtualisation = {
    libvirtd = {
<<<<<<< HEAD
      enable = false;
      onBoot = "ignore";
=======
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
>>>>>>> 0fce02f ((ツ)_/¯ Edit: 03-07-2024 11:52:51 PM)

      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
        package = pkgs.qemu_kvm;
        runAsRoot = false;
      };
    };

    spiceUSBRedirection.enable = true;
  };
  environment.etc = {
    "ovmf/edk2-x86_64-secure-code.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
    };
  };
  environment.sessionVariables.LIBVIRT_DEFAULT_URI = "qemu:///system";
  services.spice-vdagentd.enable = true;
  systemd.services.libvirtd.restartIfChanged = false;
<<<<<<< HEAD

=======
  
>>>>>>> 0fce02f ((ツ)_/¯ Edit: 03-07-2024 11:52:51 PM)
  #---------------------------------------------------------------------
  # VM variant configuration - config MEM & Cores
  #---------------------------------------------------------------------
  virtualisation.vmVariant = {
    virtualisation = {
<<<<<<< HEAD
      cores = 4;
      memory = {
        startup = 4096; # 4GB startup memory
        minimum = 2048; # 2GB minimum memory
        maximum = 6384; # 6GB maximum memory
=======
      cores = 8; # Number of CPU cores to allocate
      memory = {
        startup = 4096; # 4GB startup memory
        minimum = 2048; # 2GB minimum memory
        maximum = 24576; # 24GB maximum memory
>>>>>>> 0fce02f ((ツ)_/¯ Edit: 03-07-2024 11:52:51 PM)
      };
    };

    docker = {
      enable = false;
      enableOnBoot = false;
      autoPrune.enable = true;
    };
  };
}
