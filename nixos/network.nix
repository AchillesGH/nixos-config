{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.extraModprobeConfig = "options cfg80211 ieee80211_regdom=IN";
  hardware.wirelessRegulatoryDatabase = true;
  networking.hostName = "nixos";
  networking.resolvconf.enable = false;
  networking.dhcpcd.enable = false;
  networking.useDHCP = false;
  networking.networkmanager.enable = true;

  services.resolved.enable = true;
  services.resolved.settings.Resolve = {
    LLMNR = false;
    MulticastDNS = false;
  };

  networking.firewall = rec {
    enable = true;
    allowedTCPPortRanges = lib.mkForce [];
    allowedUDPPortRanges = lib.mkForce [];
  };
}
