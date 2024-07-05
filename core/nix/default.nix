{
  config,
  lib,
  pkgs,
  unstable,
  inputs,
  user,
  ...
}:
with lib;
let
  name = "tolga";
in
{
  imports = [ 
    ./nixpkgs-config 
  ];

  #---------------------------------------------------------------------
  # System optimisations
  #---------------------------------------------------------------------
  nix = {    
    package = pkgs.nixVersions.latest;
    distributedBuilds = true;

    # optional, useful when the builder has a faster internet connection 
    extraOptions = ''
      builders-use-substitutes = true
      experimental-features = nix-command flakes
      extra-platforms = x86_64-linux i686-linux aarch64-linux
      verbose = true
    '';

    settings = {
      allowed-users = [
        "@wheel"
        "${name}"
      ];

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

      # Opinionated: disable global registry
      flake-registry = "";

      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;

      auto-optimise-store = true;
      supportedFeatures = [ "big-parallel" ];    # Enable support for big parallel builds
      system-features = [ "i686-linux" "x86_64-linux" "big-parallel" "kvm" ];

      experimental-features = [
        "flakes"
        "nix-command"
        "repl-flake"
      ];

      cores = 8;               # Number of CPU cores allocated for the task (0 means all available cores)
      sandbox = "relaxed";     # Sandbox mode for running tasks, allowing broader system access for flexibility

      # Accelerate package building (optimized for 8GB RAM and dual-core processor with Hyper-Threading)
      buildCores = lib.mkDefault 8;              # Specify 4 build cores for parallel building
      max-jobs = lib.mkDefault 8;                # Set to 4 as the i7-3667U has 2 cores with 4 threads
      speedFactor = 2;                           # Set speed factor to 2 for build performance optimization

      trusted-users = [
        "${name}"
        "@wheel"
        "root"
      ];

      keep-derivations = true;    # Keep derivations (intermediate build artifacts) after build completion
      keep-outputs = true;        # Keep build outputs (resulting artifacts) after build completion
      tarball-ttl = 300;          # Set the time-to-live (in seconds) for cached tarballs to 300 seconds (5 minutes)
      warn-dirty = false;         # Disable warning for dirty builds (when sources have uncommitted changes)

    };

    daemonCPUSchedPolicy = "idle";     # Set CPU scheduling policy for daemon processes to idle
    daemonIOSchedPriority = 7;         # Set I/O scheduling priority for daemon processes to 7

    gc = {
      automatic = true;                  # Enable automatic execution of the task
      dates = "weekly";                  # Schedule the task to run weekly
      options = "--delete-older-than 10d";  # Specify options for the task: delete files older than 10 days
      randomizedDelaySec = "14m";        # Introduce a randomized delay of up to 14 minutes before executing the task
    };

    # Opinionated: enable channels
    channel.enable = true;
  };

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  # XDG  paths
  #environment.sessionVariables = rec {
  #  XDG_CACHE_HOME = "$HOME/.cache";
  #  XDG_CONFIG_HOME = "$HOME/.config";
  #  XDG_DATA_HOME = "$HOME/.local/share";
  #  XDG_RUNTIME_DIR = "/run/user/$UID";
  #  XDG_STATE_HOME = "$HOME/.local/state";

    # Not officially in the specification
    #XDG_BIN_HOME = "$HOME/.local/bin";
    #PATH = [
    #  "${XDG_BIN_HOME}"
    #];
  #};
}
