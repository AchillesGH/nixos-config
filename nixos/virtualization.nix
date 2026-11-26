{pkgs, ...}: {
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = ["achilles"];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Creates a 'docker' alias mapping to podman
  };

  systemd.tmpfiles.rules = [
    "w /sys/devices/pci0000:00/0000:00:02.0/sriov_drivers_autoprobe -   -   -   -   0"
    "w /sys/devices/pci0000:00/0000:00:02.0/sriov_numvfs -    -    -    -   2"
  ];
}
