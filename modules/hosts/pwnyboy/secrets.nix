{ inputs, ... }:
let
  sopsFile = inputs.self + /secrets/pwnyboy.sops.yaml;
in
{
  den.aspects.pwnyboy = {
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
