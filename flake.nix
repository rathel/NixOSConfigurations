{
	description = "NixOS Configurations";
	inputs = {
		nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
		home-manager.url = github:nix-community/home-manager;
	};

	outputs = { self, nixpkgs, home-manager, ... }:
	let
	  system = "x86_64-linux";
	in 
	{
		nixosConfigurations.alpha = nixpkgs.lib.nixosSystem {
			system = { inherit system };
			modules = [ ./alpha/configuration.nix ];
		};

		nixosConfigurations.beta = nixpkgs.lib.nixosSystem {
			system = { inherit system };
			modules = [ ./beta/configuration.nix ];
		};
	};
}
