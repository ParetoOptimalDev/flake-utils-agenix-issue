{ config, pkgs, ... }:

{
  # Root file system and bootloader is required for CI to build system configuration
  boot.loader.grub.devices = [ "nodev" ];
  fileSystems."/" = { device = "test"; fsType = "ext4"; };

  environment.systemPackages = [ agenix.defaultPackage.x86_64-linux ];

  users = {
    mutableUsers = false;
    users.morty = {
      password = "hunter2";
      extraGroups = [ "wheel" ];
      isNormalUser = true;
    };
    users.root.password = "root";
  };

  system.stateVersion = "21.05";
}
