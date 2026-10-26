{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom=IN
    options mt76 disable_mlo=Y
  '';
  hardware.wirelessRegulatoryDatabase = true;
  networking.hostName = "nixos";
  networking.resolvconf.enable = false;
  networking.dhcpcd.enable = false;
  networking.useDHCP = false;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    General = {
      EnableNetworkConfiguration = false;
      AddressRandomization = "network";
      AddressRandomizationRange = "full";
      Country = "IN";
    };
    DriverQuirks = {
      PowerSaveDisable = "*";
    };
  };

  services.resolved.enable = true;
  services.resolved.settings.Resolve = {
    DNSSEC = "yes";
    DNSOverTLS = "yes";
    LLMNR = false;
    MulticastDNS = false;
  };
  sops.templates.resolved = {
    content = ''
      [Resolve]
      DNS=45.90.28.0#${config.sops.placeholder.nextdns}.dns.nextdns.io
      DNS=2a07:a8c0::#${config.sops.placeholder.nextdns}.dns.nextdns.io
      DNS=45.90.30.0#${config.sops.placeholder.nextdns}.dns.nextdns.io
      DNS=2a07:a8c1::#${config.sops.placeholder.nextdns}.dns.nextdns.io
    '';
    path = "/etc/systemd/resolved.conf.d/dns.conf";
    restartUnits = ["systemd-resolved.service"];
    mode = "0444";
  };

  networking.firewall = rec {
    enable = true;
    allowedTCPPortRanges = lib.mkForce [];
    allowedUDPPortRanges = lib.mkForce [];
  };
}
