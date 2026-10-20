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
  networking.networkmanager.enable = false;
  systemd.network = {
    enable = true;
    networks = {
      "10-wired" = {
        matchConfig.Name = "en*";
        networkConfig = {
          DHCP = "yes";
          IPv6AcceptRA = true;
        };
        dhcpV4Config.RouteMetric = 100;
        ipv6AcceptRAConfig.RouteMetric = 100;
      };

      "20-wireless" = {
        matchConfig.Type = "wlan";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true;
          IgnoreCarrierLoss = "3s";
        };
        dhcpV4Config.RouteMetric = 600;
        ipv6AcceptRAConfig.RouteMetric = 600;
        linkConfig.RequiredForOnline = "no";
      };
    };
  };
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
    LLMNR = false;
    MulticastDNS = false;
  };

  networking.firewall = rec {
    enable = true;
    allowedTCPPortRanges = lib.mkForce [];
    allowedUDPPortRanges = lib.mkForce [];
  };
}
