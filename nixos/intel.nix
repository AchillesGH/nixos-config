{pkgs, ...}: {
  services.xserver.videoDrivers = ["modesetting"];
  boot.kernelParams = [
    "i915.force_probe=!b0a0"
    "xe.force_probe=b0a0"
  ];
  # boot.initrd.kernelModules = [ "xe" ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
  };
}
