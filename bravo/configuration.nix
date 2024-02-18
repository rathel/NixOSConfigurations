# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

# Bootloader.
  boot.loader.systemd-boot = { 
  	enable = true;
	configurationLimit = 10;
	};
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;

	hardware.opengl = {
	  ## radv: an open-source Vulkan driver from freedesktop
	  driSupport = true;
	  driSupport32Bit = true;
	
	  ## amdvlk: an open-source Vulkan driver from AMD
	  extraPackages = [ pkgs.amdvlk ];
	  extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	programs.steam.enable = true;
	programs.steam.gamescopeSession.enable = true;
	hardware.steam-hardware.enable = true;

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	programs.starship.enable = true;

	networking.hostName = "bravo"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
		networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "America/Denver";

# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

# Configure keymap in X11
	services.xserver = {
		xkb.layout = "us";
		xkb.variant = "";
	};

	services.xserver = { 
		enable = true;
		#displayManager.defaultSession = "none+openbox";
		displayManager.defaultSession = "hyprland";
		displayManager.autoLogin.enable = true;
		displayManager.autoLogin.user = "rathel";
		windowManager.openbox.enable = true;
	};

#	services.cage = {
#		user = "rathel";
#		program = "${pkgs.steam}/bin/steam -tenfoot";
#		enable = true;
#	};

	services.zerotierone.enable = true;

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.rathel = {
		isNormalUser = true;
		description = "rathel";
		extraGroups = [ "networkmanager" "wheel" "lp" ];
		packages = with pkgs; [];
	};

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
			bat
			distrobox
			fastfetch
			fd
			firefox
			gcc
			git
			htop
			kitty
			neovim
			parted
			picom
			protonup-ng
			pulsemixer
			lf
			ripgrep
			spotifyd
			steamcmd
			tmux
			usbutils
			wget
	];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
	services.openssh.enable = true;
	security.rtkit.enable = true;
	services.pipewire ={ 
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	virtualisation.podman.enable = true;


# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ];
# networking.firewall.allowedUDPPorts = [ 8211 ];
# Or disable the firewall altogether.
 networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?

}
