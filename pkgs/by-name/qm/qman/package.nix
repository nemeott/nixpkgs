{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  python3Packages,
  pkg-config,
  cmake,
  ncurses,
  zlib,
  bzip2,
  xz,
  cunit,
  man-db,
  groff,
  xdg-utils,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  __structuredAttrs = true;

  pname = "qman";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "plp13";
    repo = "qman";
    tag = "v${finalAttrs.version}";
    hash = "sha256-z3ILbbwcCYZT8qabVaGnMCyZRag8djEI32i6G7cLL2A=";
  };

  nativeBuildInputs = [
    meson
    ninja
    python3Packages.cogapp
    pkg-config
    cmake
    ncurses
    zlib
    bzip2
    xz
    cunit
    man-db
    groff
    xdg-utils
  ];

  mesonFlags = [
    "-Dconfigdir=${placeholder "out"}/etc/xdg/qman"
  ];

  postPatch = ''
    patchShebangs src/qman_tests_list.sh
    substituteInPlace src/config_def.py \
    --replace-fail '"/usr/bin/man"' '"${lib.getExe man-db}"' \
    --replace-fail '"/usr/bin/groff"' '"${lib.getExe groff}"' \
    --replace-fail '"/usr/bin/whatis"' '"${man-db}/bin/whatis"' \
    --replace-fail '"/usr/bin/apropos"' '"${man-db}/bin/apropos"' \
    --replace-fail '"/usr/bin/xdg-open"' '"${xdg-utils}/bin/xdg-open"' \
    --replace-fail '"/usr/bin/xdg-email"' '"${xdg-utils}/bin/xdg-email"'
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A more modern man page viewer for our terminals";
    homepage = "https://github.com/plp13/qman";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nemeott ];
    mainProgram = "qman";
    platforms = lib.platforms.all;
  };
})
