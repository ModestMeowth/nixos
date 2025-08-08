{
  wsl = {
    enable = true;
    useWindowsDriver = true;
    startMenuLaunchers = true;
    defaultUser = "mm";

    wslConf = {
      user.default = "mm";
      interop.appendWindowsPath = true;
    };
  };
}
