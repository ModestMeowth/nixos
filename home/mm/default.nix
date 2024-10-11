{hostname, ... }: {
  imports = [
    ../_modules
    ./${hostname}
  ];
}
