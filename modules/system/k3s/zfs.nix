{pkgs, ...}: {
  virtualisation.containerd = {
    enable = true;
    settings = let
      fullCNIPlugins = pkgs.buildEnv {
        name = "full-cni";
        paths = with pkgs; [
          cni-plugins
          cni-plugins-flannel
        ];
      };
    in {
      plugins."io.containerd.grpc.v1.cri".cni = {
        bin_dir = "${fullCNIPlugins}/bin";
        conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d/";
      };
    };
  };

  services.k3s.extraFlas = toString [
    "--container-runtime-endpoint unix:///run/containerd/containerd.sock"
  ];
}
