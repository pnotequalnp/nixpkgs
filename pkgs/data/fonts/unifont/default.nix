{ stdenv, fetchurl, mkfontscale
, libfaketime, fonttosfnt
}:

stdenv.mkDerivation rec {
  pname = "unifont";
  version = "13.0.04";

  ttf = fetchurl {
    url = "mirror://gnu/unifont/${pname}-${version}/${pname}-${version}.ttf";
    sha256 = "sha256-p0wSTyXCXuWIw+hDZ4HZPxgdBJ6oOOqOuX6FzZJmwrE=";
  };

  pcf = fetchurl {
    url = "mirror://gnu/unifont/${pname}-${version}/${pname}-${version}.pcf.gz";
    sha256 = "sha256-sKY2qshNV3zXfD2BSbfs0qom1gPt7vD5QmVEkACmx18=";
  };

  nativeBuildInputs = [ libfaketime fonttosfnt mkfontscale ];

  phases = [ "buildPhase" "installPhase" ];

  buildPhase =
    ''
      # convert pcf font to otb
      faketime -f "1970-01-01 00:00:01" \
      fonttosfnt -g 2 -m 2 -v -o "unifont.otb" "${pcf}"
    '';

  installPhase =
    ''
      # install otb fonts
      install -m 644 -D unifont.otb "$out/share/fonts/unifont.otb"
      mkfontdir "$out/share/fonts"

      # install pcf and ttf fonts
      install -m 644 -D ${pcf} $out/share/fonts/unifont.pcf.gz
      install -m 644 -D ${ttf} $out/share/fonts/truetype/unifont.ttf
      cd "$out/share/fonts"
      mkfontdir
      mkfontscale
    '';

  meta = with stdenv.lib; {
    description = "Unicode font for Base Multilingual Plane";
    homepage = "http://unifoundry.com/unifont.html";

    # Basically GPL2+ with font exception.
    license = "http://unifoundry.com/LICENSE.txt";
    maintainers = [ maintainers.rycee maintainers.vrthra ];
    platforms = platforms.all;
  };
}
