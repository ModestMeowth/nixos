{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    dirb
    gobuster
    urlhunter
    wfuzz
    zap
  ];
}
