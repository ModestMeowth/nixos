{den, ...}: {
  den.schema = {
    host.includes = [ den.batteries.user-aspects ];
    user.classes = [ "homeManager" ];
  };
}
