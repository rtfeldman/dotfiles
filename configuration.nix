# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Allow nvidia drivers
  nixpkgs.config.allowUnfree = true;

  # Enable zsh
  programs.zsh.enable = true;

  # Enable OpenGL and PulseAudio
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.enable = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  #
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "focus"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget 

    gimp

    i3 i3lock compton

    git python gnumake

    neovim firefox

    zsh tmux xclip fzf ssh-ident

    binutils

    mysql57
  ];

  environment.variables = {
    EDITOR = pkgs.lib.mkOverride 0 "nvim";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.dpi = 142;
  services.xserver.videoDrivers = [ "nvidia" ];

  # This is needed *in addition to* services.xserver.dpi - otherwise browsers look bad.
  fonts.fontconfig.dpi = 142;

  # Enable the i3 Window Manager
  services.xserver.windowManager.i3.enable = true;

  #services.xserver.synaptics = {
   # enable = true;
   # twoFingerScroll = true;
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  # Compton is a visual compositor. Without it, I can see screen tearing on fullscreen video or when scrolling quickly.
  services.compton.enable = true;
  services.compton.fade = false;
  services.compton.shadow = false;
  services.compton.backend = "glx";
  services.compton.vSync = "opengl-swc";

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sda3";
      preLVM = true;
    }
  ];

  services.mysql.package = pkgs.mysql57;
  services.mysql.enable = true;

  # networking.wireless.enable = true;

  users.extraUsers.rtfeldman = {
    name = "rtfeldman";
    group = "users";
    extraGroups = [
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal"
    ];
    createHome = true;
    uid = 1000;
    home = "/home/rtfeldman";
    shell = "/run/current-system/sw/bin/zsh";
  };
}
