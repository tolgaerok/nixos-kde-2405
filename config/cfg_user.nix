{ vars, ... }:
{
  users = {
    # mutableUsers = false;
    groups.${name} = {
      members = [ ];
    };

    extraUsers.${name} = {
      name = "${name}";
      group = "${name}";
    };

    users.${vars.name} = {
      isNormalUser = true;
      description = vars.name;
      extraGroups = [
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

      openssh = {
        authorizedKeys = {
          keys = [
            ### "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGg5V+YAm36cZcZBZz1fv7+0kP05DpoGs1EhcrlI09i kingtolga@gmail.com"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgYpmkzd4gwbnFo25VQcGp1rGiYtYjRv3RvETD0nAz/"
          ];
        };
      };
    };
  };
}
