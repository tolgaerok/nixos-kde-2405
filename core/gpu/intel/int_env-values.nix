{
  config,

  lib,
  ...
}:
# Set environment variables related to Intel graphics
{
  environment.variables = {
    # LIBVA_DRIVER_NAME = "i965"; }; # Force Intel i965 driver
    LIBVA_DRIVER_NAME = "intel";
    NIXOS_OZONE_WL = "1";
  };
}
