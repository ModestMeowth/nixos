{withSystem, inputs, ...}:
let
  flakeLib = import ./lib.nix { inherit inputs withSystem; };
  mkHost = flakeLib.mkHost;
  mkHome = flakeLib.mkHome;
in
{
  flake.nixosConfigurations = {
    "rocinante" = mkHost { hostname = "rocinante"; };
    "pwnyboy" = mkHost { hostname = "pwnyboy"; };

    "videodrome" = mkHost {
      hostname = "videodrome";
      mod = with inputs; [
        wsl.nixosModules.wsl
      ];
    };

    "skinman" = mkHost {
      hostname = "skinman";
      mod = with inputs; [
        nixos-hardware.nixosModules.raspberry-pi-4
      ];
    };

    rpi = inputs.nixpkgs.lib.nixosSystem {
      modules = [ ./nixosModules/rpi/mkimg.nix ];
    };
  };

  flake.homeConfigurations = {
    "mm@rocinante" = mkHome { hostname = "rocinante"; };
    "mm@pwnyboy" = mkHome { hostname = "pwnyboy"; };
    "mm@videodrome" = mkHome { hostname = "videodrome"; };
    "mm@skinman" = mkHome { hostname = "skinman"; system = "aarch64-linux"; };
  };
}
