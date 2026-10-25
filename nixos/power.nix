{pkgs, ...}: {
  services.upower.enable = true;
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    pd.enable = true;

    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";

      INTEL_GPU_POWER_PROFILE_ON_AC = "base";
      INTEL_GPU_POWER_PROFILE_ON_BAT = "power_saving";

      INTEL_GPU_MIN_FREQ_ON_AC = 300;
      INTEL_GPU_MAX_FREQ_ON_AC = 2450;
      INTEL_GPU_BOOST_FREQ_ON_AC = 2450; # Map to max target to avoid driver confusion

      INTEL_GPU_MIN_FREQ_ON_BAT = 300;
      INTEL_GPU_MAX_FREQ_ON_BAT = 950;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 950;

      USB_DENYLIST = "046d:c07e 1ea7:0066";
    };
  };
  security.doas.extraRules = [
    {
      users = ["confman"];
      noPass = true;
      keepEnv = false;
      cmd = "tlp-stat";
      args = ["-g"];
    }
  ];

  boot.kernelParams = [
    "mem_sleep_default=s2idle"
    "nvme_core.default_ps_max_latency_us=0"

    "mt7925e.disable_aspm=1" # Disables aggressive power management sleep loops
    "swiotlb=65535" # Expands the bounce buffer size for I/O memory allocation
  ];
}
