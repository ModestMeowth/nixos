{
  sops = {
    secrets."tskey" = {
      mode = "0440";
      group = "wheel";
      sopsFile = ./secrets.sops.yaml;
    };
  };
}
