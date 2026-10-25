{
  lib,
  stdenv,
  fetchFromGitHub,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "cake-autorate";
  version = "3.2.2";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "lynxthecat";
    repo = "cake-autorate";
    tag = "v${finalAttrs.version}";
    hash = "sha256-2WnMmilrVgVwjHK5ZkoXrzVlofuvvwQbSROfvd4RbEk=";
  };

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Eliminate the excess latency and jitter terrorizing your 4G, 5G, LTE, Starlink or other variable rate connection";
    homepage = "https://github.com/lynxthecat/cake-autorate";
    changelog = "https://github.com/lynxthecat/cake-autorate/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ nemeott ];
    mainProgram = "cake-autorate";
    platforms = lib.platforms.all;
  };
})
