{ inputs, ... }:
  let
    sopsFile = inputs.self + /secrets/thoughtpolice.sops.yaml;
  in
{
  den.aspects.thoughtpolice = {
      nixos = {
        sops.secrets."tskey" = {
          mode = "0440";
          group = "wheel";
          sopsFile = sopsFile;
        };
      };
    };
}
