{ ... }:
{
  # Configuration for  intel gpu acceleration & tlp
  imports = [
    ../openGL/opengl.nix
    ./int_env-values.nix
    ./int_generic.nix
    ./int_pkgs.nix
    ./int_power-manage.nix
  ];
}
