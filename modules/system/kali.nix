{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # exploitation
    metasploit
    # forensices
    ghidra
    # recon
    dnsenum
    dnsrecon
    hping
    netcat
    nmap
    ntopng
    wireshark
    # passwords
    crowbar
    hashcat
    john
    dsniff
    # vuln analysis
    grype
    lynis
    vulnix
    # burpsuite
    dirb
    gobuster
    urlhunter
    wfuzz
    zap
  ];
}
