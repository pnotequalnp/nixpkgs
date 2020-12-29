{ stdenv, lib, fetchurl, autoreconfHook, pkg-config
, jansson, openssl }:

stdenv.mkDerivation rec {
  name = "libjwt-${version}";
  version = "v1.12.1";

  src = fetchurl {
    url = "https://github.com/benmcollins/libjwt/archive/${version}.tar.gz";
    sha256 = "05yc8giw1kj5cwqd0a15p7w9wlymkzk11sahcc3hnd1psi8457nj";
  };

  buildInputs = [ jansson openssl ];
  nativeBuildInputs = [ autoreconfHook pkg-config ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/benmcollins/libjwt";
    description = "JWT C Library";
    license = licenses.mpl20;
    platforms = platforms.all;
  };
}
