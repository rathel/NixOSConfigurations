# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  services.xserver = { 
    enable = true;
    #displayManager.defaultSession = "enlightenment";
    #displayManager.defaultSession = "none+awesome";
    #displayManager.defaultSession = "hyprland";
    #displayManager.defaultSession = "wayfire";
    #desktopManager.enlightenment.enable = true;
    #windowManager.awesome.enable = true;
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "rathel";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    #displayManager.sddm.enable = true;
    #desktopManager.plasma5.enable = true;
  };

  #services.xserver.videoDrivers = ["nvidia"];
  #hardware.nvidia = {

  #  # Modesetting is required.
  #  modesetting.enable = true;

  #  # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
  #  powerManagement.enable = false;
  #  # Fine-grained power management. Turns off GPU when not in use.
  #  # Experimental and only works on modern Nvidia GPUs (Turing or newer).
  #  powerManagement.finegrained = false;

  #  # Use the NVidia open source kernel module (not to be confused with the
  #  # independent third-party "nouveau" open source driver).
  #  # Support is limited to the Turing and later architectures. Full list of 
  #  # supported GPUs is at: 
  #  # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
  #  # Only available from driver 515.43.04+
  #  # Currently alpha-quality/buggy, so false is currently the recommended setting.
  #  open = false;

  #  # Enable the Nvidia settings menu,
  #      # accessible via `nvidia-settings`.
  #  nvidiaSettings = true;
  #  package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  #};

# services.blueman.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
# If you want to use JACK applications, uncomment this
#jack.enable = true;
  };

  services.zerotierone.enable = true;

  services = {
    syncthing = {
      enable = true;
      user = "rathel";
      dataDir = "/home/rathel/Documents";    # Default folder for new synced folders
        configDir = "/home/rathel/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };


  networking.hostName = "alpha"; # Define your hostname.
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

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rathel = {
    isNormalUser = true;
    description = "rathel";
    extraGroups = [ "networkmanager" "wheel" "lp" "audio" "video" ];
    packages = with pkgs; [ 
      ardour
      bat
      blender
      brave
      distrobox
      element-desktop
      eza
      fastfetch 
      fd
      flameshot
      floorp 
      fuse-common
      gimp
      git
      godot_4
      lf
      htop
      jq
      kitty
      lftp
      libreoffice-fresh
      librewolf
      lmms
      lutris
      lxappearance
      microsoft-edge
      mpv
      mumble
      nmap
      nodejs
      persepolis
      picom
      protonup-ng
      pulsemixer
      qemu
      redshift
      ripgrep
      rosegarden
      rpi-imager
      spicetify-cli
      spotify
      sshfs
      starship
      tealdeer
      thunderbird
      variety
      ventoy-full
      vivaldi
      vivaldi-ffmpeg-codecs
      w3m 
      wine
      wofi
      yt-dlp
      zellij
      zoxide
      ];
  };

  fonts.packages = with pkgs; [
  nerdfonts
  intel-one-mono
  ];

#  home-manager.users.rathel = { pkgs, ... }: {
#  programs.bash.enable = true;
#  home.stateVersion = "23.11";
#  };

# Enable automatic login for the user.
  services.getty.autologinUser = "rathel";

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.nvidia.acceptLicense = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
      appimage-run
      usbimager
      broadcom-bt-firmware
      cryptsetup
      wget
      neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];

  programs.wayfire.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true;
  };

  programs.firefox = { 
    enable = true;
    package = pkgs.firefox-devedition;
  };

#environment.variables = {
#  QT_QPA_PLATFORMTHEME = "wayland;xcb";
#  GBM_BACKEND = "nvidia-drm";
#  __GLX_VENDOR_LIBRARY_NAME = "nvidia";
#  ENABLE_VKBASALT = "1";
#  LIBVA_DRIVER_NAME = "nvidia";
#  WLR_NO_HARDWARE_CURSORS = "1";
#};

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

  programs.hyprland = { 
    enable = true;
    xwayland.enable = true;
#    enableNvidiaPatches = true;
  };


# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
