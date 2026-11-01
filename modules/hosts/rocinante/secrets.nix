{ inputs, ... }:
let
  sopsFile = inputs.self + /secrets/rocinante.sops.yaml;
in
{
  den.aspects.rocinante = {
    nixos = {
      sops = {
        secrets."tskey" = {
          mode = "0440";
          group = "wheel";
          sopsFile = sopsFile;
        };

        secrets."cache-priv-key" = {
          mode = "0440";
          group = "wheel";
          sopsFile = sopsFile;
        };

        secrets."ha-nut-user" = {
          mode = "0440";
          group = "wheel";
        };
      };
    };
  };
}
