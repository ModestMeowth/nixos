{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fluxcd
    kubernetes-helm
    kustomize
  ];
}
