{ stdenv, fetchgit, coreutils, python3 }:

stdenv.mkDerivation rec {
  name = "acpilight-${version}";
  version = "1.1";

  src = fetchgit {
    url = "https://gitlab.com/wavexx/acpilight.git";
    rev = "v${version}";
    sha256 = "0kykrl71fb146vaq8207c3qp03h2djkn8hn6psryykk8gdzkv3xd";
  };

  buildInputs = [ python3 ];

  postPatch = ''
    substituteInPlace 90-backlight.rules \
      --replace '/bin/chgrp' '${coreutils}/bin/chgrp' \
      --replace '/bin/chmod' '${coreutils}/bin/chmod'
    substituteInPlace Makefile \
      --replace "udevadm trigger -s backlight -c add" ""
  '';

  makeFlags = [ "DESTDIR=$(out)" ];

  meta = with stdenv.lib; {
   description = "backward-compatibile xbacklight replacement";
   homepage = https://gitlab.com/wavexx/acpilight;
   license = licenses.gpl3;
   maintainers = with maintainers; [ bricewge ];
   platforms = platforms.linux ;
  };
}
