{
  sops.secrets."tskey" = {
    mode = "0440";
    group = "wheel";
    sopsFiles = ./secrets.sops.yaml;
  };
}
