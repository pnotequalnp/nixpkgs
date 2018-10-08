{ stdenv, fetchFromGitHub, cmake, perl
, alsaLib, libevdev, libopus, udev, SDL2
, ffmpeg, pkgconfig, xorg, libvdpau, libpulseaudio, libcec
, curl, expat, avahi, enet, libuuid
}:

stdenv.mkDerivation rec {
  name = "moonlight-embedded-${version}";
  version = "2.4.6";

  src = fetchFromGitHub {
    owner = "irtimmer";
    repo = "moonlight-embedded";
    rev = "v${version}";
    sha256 = "0vs6rjmz8058s9lscagiif6pcizwfrvfpk9rxxgacfi0xisfgmf1";
    fetchSubmodules = true;
  };

  outputs = [ "out" "man" ];

  nativeBuildInputs = [ cmake perl ];
  buildInputs = [
    alsaLib libevdev libopus udev SDL2
    ffmpeg pkgconfig xorg.libxcb libvdpau libpulseaudio libcec
    xorg.libpthreadstubs curl expat avahi enet libuuid
  ];

  meta = with stdenv.lib; {
    description = "Open source implementation of NVIDIA's GameStream";
    homepage = https://github.com/irtimmer/moonlight-embedded;
    license = licenses.gpl3;
    maintainers = [ maintainers.globin ];
    platforms = platforms.linux;
  };
}
