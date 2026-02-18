{ config, lib, ... }:
let
  cfg = config.networking.networkmanager;
in
{
  config.networking.networkmanager.ensureProfiles.profiles = lib.mkIf cfg.enable {
    "Ponyboy Bounce House" = {
      connection.id = "Ponyboy Bounce House";
      connection.uuid = "0b2350c1-22f0-46d0-819b-0e4eb20d9cca";
      connection.type = "wifi";

      wifi.mode = "infrastructure";
      wifi.ssid = "Ponyboy Bounce House";

      wifi-security.auth-alg = "open";
      wifi-security.key-mgmt = "wpa-psk";
      wifi-security.psk = "ecb174755f12819ece61d5e729e2f41c8b34820f2210b2ae9c226188b3864b34";

      ipv4.method = "auto";
      ipv6.addr-gen-mode = "default";
      ipv6.method = "auto";
    };

    "Hyrule" = {
      connection.id = "Hyrule";
      connection.uuid = "691850b5-dbd2-4fdb-acff-62e3ef5390f1";
      connection.type = "wifi";

      wifi.mode = "infrastructure";
      wifi.ssid = "Hyrule";

      wifi-security.auth-alg = "open";
      wifi-security.key-mgmt = "wpa-psk";
      wifi-security.psk = "32534f26bab09e2713a8fdd3586007d283fcdb7be68893c835f85e1eb01f414d";

      ipv4.method = "auto";
      ipv6.addr-gen-mode = "default";
      ipv6.method = "auto";
    };
  };
}
