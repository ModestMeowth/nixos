{
  sops = {
    secrets."tskey" = {
      mode = "0440";
      group = "wheel";
      sopsFile = ./secrets.sops.yaml;
    };

    secrets."cache-priv-key" = {
      mode = "0440";
      group = "wheel";
      sopsFile = ./secrets.sops.yaml;
    };

    secrets."ha-nut-user" = {
      mode = "0440";
      group = "wheel";
    };
  };
}
