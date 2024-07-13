{ config, lib, ... }:

{
  imports = [
    ./nv_drivers.nix
    ./nv_tweaks.nix
  ];
}
