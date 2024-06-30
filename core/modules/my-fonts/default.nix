{ config, pkgs, ... }:

# Does a fetchFromGitHub to DL my fonts from my repo
#   https://github.com/tolgaerok/apple-fonts
#   https://github.com/tolgaerok/fonts-tolga

{
  fonts.packages = with pkgs; [ 
    (callPackage ./my-fonts.nix { }) 
    (callPackage ./wps-fonts.nix { })
  ];
}
