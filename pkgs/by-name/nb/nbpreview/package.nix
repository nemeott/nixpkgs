{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonApplication (finalAttrs: {
  __structuredAttrs = true;

  pname = "nbpreview";
  version = "0.10.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "paw-lu";
    repo = "nbpreview";
    tag = "v${finalAttrs.version}";
    hash = "sha256-BRWywEeTMN6aq0Cof/7fIpS967VYqfzW2ufFxi+2q5Y=";
  };

  build-system = [
    python3.pkgs.poetry-core
  ];

  dependencies = with python3.pkgs; [
    click-help-colors
    html2text
    httpx
    ipython
    jinja2
    lxml
    markdown-it-py
    mdit-py-plugins
    nbformat
    picharsso
    pillow
    pygments
    pylatexenc
    rich
    term-image
    typer
    types-click
    validators
    yarl
  ];

  pythonImportsCheck = [
    "nbpreview"
  ];

  meta = {
    description = "A terminal viewer for Jupyter notebooks. It's like cat for ipynb files";
    homepage = "https://github.com/paw-lu/nbpreview";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "nbpreview";
  };
})
