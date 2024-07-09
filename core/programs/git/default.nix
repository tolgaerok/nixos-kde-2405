{ lib, pkgs, ... }:

{
  imports = [

  ];

  environment.systemPackages = with pkgs; [
    gcc
    gitfs
    python39Packages.virtualenv
  ];

  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;

      lfs = {
        enable = true;
      };

      config = {
        commit = {
          # Adjust GPG signing preferences as needed
          # gpgsign = "false";
          # signingKey = "ssh-ed25519";
        };

        init = {
          defaultBranch = "main";
        };

        pull = {
          rebase = true;
        };

        credential.helper = "cache";

        # editor = "kate";
        github.user = "tolgaerok";

        url = {
          "git@github.com:" = {
            insteadOf = [ "https://github.com/" ];
          };

          "git@gitlab.com:" = {
            insteadOf = [ "https://gitlab.com/" ];
          };
        };

        status = {
          short = true;
        };
      };
    };
  };
}
