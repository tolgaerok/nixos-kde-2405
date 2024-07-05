{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
with lib;
let
  name = "tolga";
in
{

  fileSystems."/mnt/QNAP" = {
    device = "//192.168.0.17/public";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=/etc/nixos/network/smb-secrets,uid=1000,gid=100" ];
  };

  services = {
    gvfs.enable = true;
    rpcbind.enable = true;
  };
}
