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
	    xorg.fontbhttf
	    xorg.fontbhlucidatypewriter100dpi
	    xorg.fontbhlucidatypewriter75dpi
	    xorg.fontbh100dpi
	    xorg.fontmiscmisc
	    xorg.fontcursormisc
    ];
  };

  environment = {
    etc."fonts/conf.d/20-no-embedded-bitmap-fonts.conf".text = ''
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <match target="font">
    <edit name="embeddedbitmap" mode="assign">
      <bool>false</bool>
    </edit>
  </match>
</fontconfig>
    '';

    etc."fonts/conf.d/29-replace-bitmap-fonts.conf".text = ''
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>
  <match target="pattern" name="family">
      <test name="family" qual="any">
          <string>Helvetica</string>
      </test>
      <edit mode="assign" name="family">
          <string>Arial</string>
          <string>Liberation Sans</string>
          <string>sans-serif</string>
      </edit>
  </match>
  <match target="pattern" name="family">
      <test name="family" qual="any">
          <string>Courier</string>
      </test>
      <edit mode="assign" name="family">
          <string>Courier New</string>
          <string>Liberation Mono</string>
          <string>monospace</string>
      </edit>
  </match>
  <match target="pattern" name="family">
      <test name="family" qual="any">
          <string>Times</string>
      </test>
      <edit mode="assign" name="family">
          <string>Times New Roman</string>
          <string>Liberation Serif</string>
          <string>serif</string>
      </edit>
  </match>
</fontconfig>
	  '';

    etc."fonts/conf.d/70-no-bitmap-fonts.conf".text = ''
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
	<selectfont>
	  <rejectfont>
	    <pattern>
	      <patelt name="scalable"><bool>false</bool></patelt>
	    </pattern>
	  </rejectfont>
	</selectfont>
</fontconfig>
    '';
  };
}
