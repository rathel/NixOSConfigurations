{
	description = "NixOS Configurations";
	inputs = {
		nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
		home-manager.url = github:nix-community/home-manager;
	};

	outputs = { self, nixpkgs, home-manager, ... }: {
		nixosConfigurations.alpha = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [ ./alpha/configuration.nix ];
		};
	};

	nixosConfigurations.beta = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [ ./beta/configuration.nix ];
	};
}
