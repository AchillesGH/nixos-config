{pkgs, ...}: {
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = ["achilles"];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Creates a 'docker' alias mapping to podman
  };
}
