{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fluxcd
    kubernetes-helm
    kustomize
  ];

  sops.secrets = {
    "cloudflare-token" = {
      group = "wheel";
      mode = "0440";
    };
    "gh-flux-token" = {
      group = "wheel";
      mode ="0440";
    };
  };
}
