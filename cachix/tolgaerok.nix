{
  nix = {
    settings = {
      substituters = [ "https://tolgaerok.cachix.org" ];
      trusted-public-keys = [ "tolgaerok.cachix.org-1:5lGNyyl0kn8/2P63QxU3FX7v1TzAvG7HVATbwXb9c3k=" ];

      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      ];
    };
  };
}
