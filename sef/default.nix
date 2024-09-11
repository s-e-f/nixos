{
  pkgs,
  inputs,
  ...
}:
let
  username = "sef";
in
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    inputs.nur.overlay
    (final: prev: { zjstatus = inputs.zjstatus.packages.${prev.system}.default; })
    (final: prev: {
      microsoft-identity-broker = prev.microsoft-identity-broker.overrideAttrs {
        src = pkgs.fetchurl {
          url = "https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.1_amd64.deb";
          hash = "sha256-I4Q6ucT6ps8/QGiQTNbMXcKxq6UMcuwJ0Prcqvov56M=";
        };
      };
    })
  ];
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./git
    ./1password
    ./nvim
    ./kitty
    (import ./firefox { inherit pkgs inputs username; })
    # (import ./hypr { inherit pkgs inputs username; })
    ./zellij
    ./starship
    ./zsh
    ./ags
    ./rofi
  ];

  home = {
    packages = with pkgs; [
      flyctl
      zip
      tlrc
      # surrealdb
      usql
      obsidian
      noto-fonts
      vivaldi
      turso-cli
      httpie
    ];
  };

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    bat = {
      enable = true;
      themes.kanagawa = {
        src = pkgs.fetchFromGitHub {
          owner = "rebelot";
          repo = "kanagawa.nvim";
          rev = "e5f7b8a804360f0a48e40d0083a97193ee4fcc87";
          hash = "sha256-FnwqqF/jtCgfmjIIR70xx8kL5oAqonrbDEGNw0sixoA=";
        };
        file = "extras/kanagawa.tmTheme";
      };
      config.theme = "kanagawa";
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep.enable = true;
    zoxide = {
      enable = true;
      options = [

      ];
    };
    jq.enable = true;
    btop.enable = true;
    eza = {
      enable = true;
      extraOptions = [
        "-l"
        "--icons"
        "--no-permissions"
        "--no-time"
        "--smart-group"
        "-a"
        "--git"
      ];
    };
    fd.enable = true;
  };

}
