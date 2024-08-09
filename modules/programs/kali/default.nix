{
  config,
  lib,
  pkgs,
  ...
}: {
  options.program.kali = {
    burpSuite.enable = lib.mkEnableOption "kali burp-suite";
    cracking.enable = lib.mkEnableOption "kali cracking tools";
    exploitation.enable = lib.mkEnableOption "kali exploitation tools";
    forensics.enable = lib.mkEnableOption "kali forensics tools";
    recon.enable = lib.mkEnableOption "kali recon tools";
    vuln.enable = lib.mkEnableOption "kali vuln tools";
  };

  config = lib.mkMerge [
    (lib.mkIf (config.progam.kali.burpSuite.enable) {
      enviroment.systemPackages = with pkgs; [
        dirb
        gobuster
        urlhunter
        wfuzz
        zap
      ];
    })

    (lib.mkIf (config.program.kali.cracking.enable) {
      environment.systemPackages = with pkgs; [
        crowbar
        hashcat
        john
        dsniff
      ];
    })

    (lib.mkIf (config.program.kali.exploitation.enable) {
      environment.systemPackages = with pkgs; [
        metasploit
      ];
    })

    (lib.mkIf (config.program.kali.forensics.enable) {
      environmnet.systemPackages = with pkgs; [
        ghidra
      ];
    })

    (lib.mkIf (config.program.kali.recon.enable) {
      environment.systemPackages = with pkgs; [
        dnsenum
        dnsrecon
        hping
        netcat
        nmap
        ntopng
        wireshark
      ];
    })

    (lib.mkIf (config.program.kali.vuln.enable) {
      environment.systemPackages = with pkgs; [
        grype
        lynix
        vulnix
        wireshark
      ];
    })
  ];
}
