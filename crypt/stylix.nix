{ pkgs, inputs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = import ../sef/stylix/colors.nix;
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
        name = "FiraCode Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  fonts.packages = with pkgs; [
    font-awesome # for waybar
  ];
}
