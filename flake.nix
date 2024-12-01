{
  description = "A simple NixOS flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-ld.url = "github:Mic92/nix-ld";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad = {
      url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };
  outputs = {  nixpkgs, nixpkgs-unstable, home-manager, ghostty, kmonad, nix-ld, ... }: 
    let
      system = "x86_64-linux";
      nixPkgsConfig = {inherit system;};
      unstable = import nixpkgs-unstable nixPkgsConfig;
    in
    {
    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        {
          nixpkgs.overlays = [
            (self: super: {
              unstable = import nixpkgs-unstable {system = self.system;};
            })
          ];
        }
        ./configuration.nix
	      ./kbd.nix
        nix-ld.nixosModules.nix-ld
        { programs.nix-ld.dev.enable = true; }
	      kmonad.nixosModules.default
        home-manager.nixosModules.home-manager 
	      {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users = {
              em = import ./home.nix;
            };
            extraSpecialArgs = {
              nixpkgs = {
                from = {
                  unstable = unstable;
                };
                for = {
                  taskwarrior3 = import nixpkgs-unstable nixPkgsConfig;
                };
              };
            };
          };
	      }
        {environment.systemPackages = [
          ghostty.packages.x86_64-linux.default
        ];}
      ];
    };
  };
}
