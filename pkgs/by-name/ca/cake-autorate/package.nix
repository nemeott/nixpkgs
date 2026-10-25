{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  bash,
  coreutils,
  fping,
  gawk,
  gnugrep,
  iproute2,
  procps,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "cake-autorate";
  version = "3.5.0-unstable-2026-08-30";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "lynxthecat";
    repo = "cake-autorate";
    rev = "ac75f49348c2ce697e698270a340d42e499cd953";
    hash = "sha256-0nIAOcTjb5avZDgr1rFQlaovM3WFMBr+qUJtKvUVpxU=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ bash ]; # so patchShebangs targets the right bash

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/cake-autorate $out/bin
    cp -r . $out/share/cake-autorate
    patchShebangs $out/share/cake-autorate

    makeWrapper $out/share/cake-autorate/cake-autorate.sh $out/bin/cake-autorate \
      --prefix PATH : ${
        lib.makeBinPath [
          coreutils
          fping
          gawk
          gnugrep
          iproute2
          procps
        ]
      }

    runHook postInstall
  '';

  meta = {
    description = "Adaptive CAKE bandwidth for variable-rate connections";
    homepage = "https://github.com/lynxthecat/cake-autorate";
    changelog = "https://github.com/lynxthecat/cake-autorate/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ nemeott ];
    mainProgram = "cake-autorate";
    platforms = lib.platforms.linux;
  };
})
