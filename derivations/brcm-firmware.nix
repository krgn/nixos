{ stdenv, fetchurl } :

stdenv.mkDerivation rec {
  name = "brcm4350-firmware-${version}";

  version = "2015-12-18";

  src = fetchurl {
    url = "http://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/plain/brcm/brcmfmac4350-pcie.bin";
    sha256 = "5691d1e0ceb70baf18efb7a0ec6cb84feb9edd2d0700c525b42930c4e7e4b845";
  };

  buildPhases = [ "unpackPhase" "installPhase" ];

  unpackPhase = ''
  echo "no unpacking needed"
  '';

  installPhase = ''
  mkdir -p "$out/lib/firmware/brcm"
  cp "$src" "$out/lib/firmware/brcm/brcmfmac4350-pcie.bin"
  '';
}
