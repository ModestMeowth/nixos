{lib, ...}:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = lib.mkDefault true;
    };

    spiceUSBRedirection.enable = true;
  };
}
