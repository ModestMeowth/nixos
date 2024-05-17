{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vulkan-tools
    clinfo
  ];
}
