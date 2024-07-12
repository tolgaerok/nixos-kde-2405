{
  config,
  pkgs,
  lib,
  name,
  ...
}:


let
  vars = import ./variables;
  userConfig = import ./cfg_user.nix vars;
  # Import and configure other files similarly
in
{
  inherit (vars) name;
  inherit (userConfig) user;
  # Combine all configurations and variables here
}