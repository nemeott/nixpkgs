{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:

buildGoModule (finalAttrs: {
  __structuredAttrs = true;

  pname = "microsoft-to-do-export";
  version = "2.4.1";

  src = fetchFromGitHub {
    owner = "daylamtayari";
    repo = "Microsoft-To-Do-Export";
    tag = "v${finalAttrs.version}";
    hash = "sha256-CgxMsgPDYq4eP1HEgG3Cu74dpUwSR9YRBsHivztzHYY=";
  };

  vendorHash = "sha256-H+lrLsPwbRV05uFBbrZLftqRfJvTQ/x4G5k4DEcdK0Q=";

  ldflags = [ "-s" ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Export all Microsoft To Do lists and tasks to importable formats";
    homepage = "https://github.com/daylamtayari/Microsoft-To-Do-Export";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ nemeott ];
    mainProgram = "microsoft-to-do-export";
  };
})
