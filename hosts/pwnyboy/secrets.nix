{
  sops.secrets = {
    "tskey".mode = "0440";
    "tskey".group = "wheel";
    "tskey".sopsFile = ./secrets.sops.yaml;

    "cache-priv-key".mode = "0440";
    "cache-priv-key".group = "wheel";
    "cache-priv-key".sopsFile = ./secrets.sops.yaml;
  };
}
