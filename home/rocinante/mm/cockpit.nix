{
  cockpit.settings.WebService = {
    Origins = "https://localhost:9090 wss://localhost:9090 https://rocinante.lan wss://rocinante.lan";
    ProtocolHeader = "X-Forwarded-Proto";
    ForwardedForHeader = "X-Forwarded-For";
  };
}
