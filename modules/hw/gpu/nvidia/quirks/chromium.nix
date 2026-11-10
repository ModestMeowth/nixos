{
  den.aspects.hw.gpu.nvidia = {
    homeManager =
      {
        programs.chromium.commandLineArgs = [
          "--enable-features=AcceleratedVideoDecodeLinuxGL,VaapiOnNvidiaGPUs"
          "--ignore-gpu-blocklist"
          "--use-gl=angle"
          "--use-angle=gl"
        ];
    };
  };
}
