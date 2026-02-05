{inputs, ...}:
{
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
    inputs.easy-hosts.flakeModules.default
    ./hosts.nix
  ];

  systems = ["aarch64-linux" "x86_64-linux"];

  # easy-hosts = {
  #   modules = [
  #     inputs.lanzaboote.nixosModules.lanzaboote
  #     inputs.nix-index-database.nixosModules.nix-index
  #     inputs.sops-nix.nixosModules.sops
  #     ./nixosModules
  #     ./users
  #   ];
  # };
}
