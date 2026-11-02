{den, ...}:
{
  den.default  = {
    includes = with den.aspects; [
      svc.mdns
    ];
  };
}
