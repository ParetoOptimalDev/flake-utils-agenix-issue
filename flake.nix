{
  description = "Very simple flake-utils-plus flake with home-manager and home-managers spotifyd with agenix secrets";  

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
    home-manager = {
      url = github:nix-community/home-manager/release-21.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = github:ryantm/agenix;
  };

  outputs = inputs@{ self, nixpkgs, utils, home-manager, agenix }:

    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      hostDefaults.modules = [
        { home-manager.users.morty.home.stateVersion = "21.05"; }

        agenix.nixosModule
        home-manager.nixosModules.home-manager
      ];

      hosts.Rick.modules = [
        ./hosts/Rick.nix
        agenix.nixosModule
      ];

    };
}
