{ stdenv, requireFile, automake, pkgconfig, cups }:

let
  version = "1.5.2";
in

stdenv.mkDerivation {
  name = "epson-inkjet-printer-${version}";

  buildInputs = [ cups ];

  src = requireFile {
    url = "http://epson.bla";
    name = "epson-inkjet-printer-escpr-1.5.2-1lsb3.2.tar.gz";
    sha256 = "1s3by0sih6411wsjznss9vpbnvn5w442s23i0sdy55ry0f5alacj";
  };
}
