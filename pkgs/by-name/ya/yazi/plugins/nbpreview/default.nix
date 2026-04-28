{
  lib,
  fetchFromGitHub,
  mkYaziPlugin,
}:
mkYaziPlugin {
  pname = "nbpreview.yazi";
  version = "0-unstable-2026-04-22";

  src = fetchFromGitHub {
    owner = "AnirudhG07";
    repo = "nbpreview.yazi";
    rev = "b50459402c52cbfd8d9262ae91e353d3300f8a8c";
    hash = "sha256-Fh0F8sa3X6w83KukSdyNw8XtYAnFYcJ36Be55z/fdRw=";
  };

  meta = {
    description = "View your Jupyter notebooks beautifully in the preview in Yazi";
    homepage = "https://github.com/AnirudhG07/nbpreview.yazi";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ nemeott ];
  };
}
