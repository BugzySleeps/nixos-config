{
  description = "Bugzy's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # Build a host from the shared config plus its per-host module.
      mkHost = hostName: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./hosts/${hostName}
        ];
      };
    in {
      nixosConfigurations = {
        nixos = mkHost "nixos";
        # Add another machine by creating ./hosts/<name>/ and listing it here:
        # laptop2 = mkHost "laptop2";
      };
    };
}
