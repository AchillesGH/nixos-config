{
  lib,
  pkgs,
  config,
  ...
}: {
  sops.secrets.main_user_pwd_hash.neededForUsers = true;

  users.mutableUsers = false;
  users.users.root.hashedPassword = "!"; # Disable root login
  users.users.achilles = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    uid = 1000;
    shell = pkgs.fish;
    packages = with pkgs; [
      tree
    ];
    home = "/home/achilles";
    hashedPasswordFile = config.sops.secrets.main_user_pwd_hash.path;
  };
  users.users.confman = {
    isNormalUser = true;
    shell = pkgs.fish;
    home = "/home/confman";
    createHome = true;
    uid = 1002;
    description = "System and user configuration manager";
    homeMode = "750";
    packages = with pkgs; [kitty];
    linger = true;
    hashedPassword = "$6$ORRkMoElXRYP5NWR$eYIGfLV1erneqr84ME4i1Im2tL0wPrPvlIpWqA1oLc542zF9i2rx6rP1RR4VZAVR8zs0F26lnWPg8ScBEJnMl.";
  };

  environment.etc."security/access.conf".text = ''
    - : confman : ALL
  '';

  security.pam.services.login.rules.account.access = {
    order = 1000;
    control = "required";
    modulePath = "pam_access.so";
    args = ["accessfile=/etc/security/access.conf"];
  };
  security.pam.services.greetd.rules.account.access = {
    order = 1000;
    control = "required";
    modulePath = "pam_access.so";
    args = ["accessfile=/etc/security/access.conf"];
  };
  security.pam.services.sshd.rules.account.access = {
    order = 1000;
    control = "required";
    modulePath = "pam_access.so";
    args = ["accessfile=/etc/security/access.conf"];
  };
  security.pam.services.login.enableGnomeKeyring = true;
}
