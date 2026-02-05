{
  sops = {
    secrets."tskey".mode = "0440";
    secrets."tskey".group = "wheel";
    secrets."tskey".sopsFile = ./secrets.sops.yaml;
  };
}
