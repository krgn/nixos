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
      # xorg.fontbhttf
      # xorg.fontbhlucidatypewriter100dpi
      # xorg.fontbhlucidatypewriter75dpi
      # xorg.fontbh100dpi
      # xorg.fontmiscmisc
      # xorg.fontcursormisc
    ];
  };
}

