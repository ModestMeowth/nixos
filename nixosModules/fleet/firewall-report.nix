{
  mkFirewallReport = interfaceName: interface: [
    (map (p:
      "TCP\t${toString p}\t${interfaceName}")
    interface.allowedTCPPorts)
    (map ({from,to}:
      "TCP\t${toString from}:${toString to}\t${interfaceName}")
    interface.allowedTCPPortRanges)
    (map (p:
      "UDP\t${toString p}\t${interfaceName}")
    interface.allowedUDPPorts)
    (map ({from,to}:
      "TCP\t${toString from}:${toString to}\t${interfaceName}")
    interface.allowedUDPPortRanges)
  ];
}
