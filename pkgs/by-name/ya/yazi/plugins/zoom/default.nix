{
  lib,
  fetchFromGitHub,
  mkYaziPlugin,
}:
mkYaziPlugin {
  pname = "zoom.yazi";
  version = "0-unstable-2026-04-22";

  src = fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "ac82af3e10f9a32cecd9f87ac64b3f9de7c7aea7";
    hash = "sha256-svc7I2E+tVMEUWUvIS6i3oTGfLq13eaI61T0c1MQ8qQ=";
  };

  meta = {
    description = "Enlarge or shrink the preview image of a file, which is useful for magnifying small files for viewing.";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ nemeott ];
  };
}
