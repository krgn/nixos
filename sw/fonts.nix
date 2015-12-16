{ config, pkgs, ... }:

{
  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      inconsolata
      anonymousPro
      source-code-pro  
      cantarell_fonts
      dejavu_fonts
      ucsFonts
      ubuntu_font_family
      ttf_bitstream_vera
      freefont_ttf
      liberation_ttf
      symbola # upstream download unavailable
      arkpandora_ttf
      baekmuk-ttf
      # bakoma_ttf
      opensans-ttf
      font-awesome-ttf
    ];
  };
}

