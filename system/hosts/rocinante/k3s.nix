{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fluxcd
    kubernetes-helm
    kustomize
  ];

  sops.secrets = {
    "cloudflare-token".mode = "0400";
    "gh-flux-token".mode ="0400";
  };
}
