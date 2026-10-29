{
  pkgs,
  config,
  ...
}: {
  programs.uwsm.enable = true;
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    greeterManagesPlymouth = true;

    settings = {
      default_session = {
        user = "greeter";
        command = with pkgs; "${lib.getExe tuigreet} --time --user-menu --remember --remember-session";
      };
    };
  };
  services.displayManager.sessionPackages = [
    config.home-manager.users.achilles.wayland.windowManager.hyprland.finalPackage
  ];
}
