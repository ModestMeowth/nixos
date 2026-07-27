{
  inputs,
  ...
}:
{
  imports = with inputs.den; [
    (namespace "gaming" true)
    (namespace "theming" true)
  ];
}
