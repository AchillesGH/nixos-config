{pkgs, ...}: {
  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox-bin.override {
    cfg = {
      speechSynthesisSupport = false;
      pipewireSupport = true;
    };
  };
  programs.firefox = {
    policies = {
      DisableFirefoxStudies = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisablePocket = true;
      DisableTelemetry = true;
      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        "*".installation_mode = "blocked";
        "uBlock0@raymondhill.net" = {
          install_url = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
      };
      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          selectedFilterLists = [
            "CZE-0"
            "adguard-generic"
            "adguard-annoyance"
            "adguard-social"
            "adguard-spyware-url"
            "easylist"
            "easyprivacy"
            "https:#github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
            "plowe-0"
            "ublock-abuse"
            "ublock-badware"
            "ublock-filters"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "urlhaus-1"
          ];
        };
      };
    };
    profiles.default = {
      isDefault = true;
      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
      };
      settings = {
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
      };
    };
  };
}
