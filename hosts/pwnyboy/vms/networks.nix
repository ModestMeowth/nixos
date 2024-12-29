{lib, ...}: {
  virtualisation.libvirtd.extraConfig = ''
    listen_tcp = 1
    listen_addr = "0.0.0.0"
    spice_tls = 1
    spice_listen = "0.0.0.0"
  '';

  networking.hosts."192.168.0.101" = ["cluster.home"];
}
