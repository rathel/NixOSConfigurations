{
	description = "NixOS Configurations";
	inputs = {
		nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
		home-manager.url = github:nix-community/home-manager;
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = inputs@{ self, nixpkgs, home-manager, ... }:
	let
	  system = "x86_64-linux";
	  username = "rathel";
	in 
	{
		nixosConfigurations.alpha = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ ./alpha/configuration.nix 
				# home-manager.nixosModules.home-manager {
				# 	home-manager.useGlobalpkgs = true;
				# 	home-manager.useUserPackages = true;
				# 	home-manager.users = { inherit username;
				# 	import = ./common-home.nix; };
				# }
				];
		};

		nixosConfigurations.bravo = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ ./bravo/configuration.nix 
			# home-manager.nixosModules.home-manager {
			# 		home-manager.useGlobalpkgs = true;
			# 		home-manager.useUserPackages = true;
			# 		home-manager.users = { inherit username;
			# 		import = ./common-home.nix; };
			# 	}
			 	];
				};


		nixosConfigurations.charlie = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ ./charlie/configuration.nix 
			home-manager.nixosModules.home-manager {
				home-manager.useGlobalPkgs = true;
			 	home-manager.useUserPackages = true;
			 	home-manager.users.${username} = import ./home.nix; 
				}
			 	];
				};
	};
}
