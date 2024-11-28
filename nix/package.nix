{
  lib,
  stdenvNoCC,
  nix-gitignore,
  texlive,
  writableTmpDirAsHomeHook,
}:
stdenvNoCC.mkDerivation {
  name = "astro-notebook";
  src = nix-gitignore.gitignoreSource [ ] (builtins.path { path = ../.; });
  nativeBuildInputs = [
    texlive
    writableTmpDirAsHomeHook
  ];

  buildPhase = ''
    runHook preBuild
    mkdir -p tikz/resource
    latexmk -pdf -xelatex -shell-escape astro-notebook.tex
    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out
    cp astro-notebook.pdf $out/
  '';

  meta = {
    description = "Астрадь - сборник теории по астрономии (третье издание)";
    longDescription = ''
      Астрадь - это сборник теории по астрономии, третье издание которого
      расширяет круг тем и глубину изложения по сравнению с предыдущими изданиями.
      Содержит теоретический материал по различным разделам астрономии.
    '';
    homepage = "https://github.com/AShepelevv/astro.notebook";
    license = lib.licenses.cc-by-nc-sa-40;
    maintainers = [
      "Алексей Шепелев"
      "Святослав Суглобов"
      "Святослав Борисов"
    ];
    platforms = lib.platforms.all;
  };
}
