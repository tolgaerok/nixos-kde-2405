{ stdenvNoCC, fetchzip }:

# Tolga Erok

stdenvNoCC.mkDerivation {
  pname = "fonts-tolga";
  version = "1.0-stable";
  src = fetchzip {
    url = "https://github.com/tolgaerok/fonts-tolga/raw/main/WPS-FONTS.zip";
    sha256 = "sha256-Pzl1+g8vaRLm1c6A0fk81wDkFOnuvtohg/tW+G1nNQo=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall  
    mkdir -p $out/share/fonts/truetype

    # CHANGE THE F***** font to lower case!    
    mv WEBDINGS.TTF webdings.ttf 
               
    find . -name "*.ttf" -type f -exec install -Dm644 {} -t "$out/share/fonts/truetype" \;
    runHook postInstall 
  '';
}

#   nix-prefetch-git https://github.com/tolgaerok/fonts-tolga
#  "url": "https://github.com/tolgaerok/fonts-tolga",
#  "rev": "bb0f2d0e8e793387a7353229bee691243153c9a7",
#  "date": "2023-07-04T21:25:36+08:00",
#  "path": "/nix/store/fgy4cxy1bw6a5zc68ri7pifsz6b452z5-fonts-tolga",
#  "sha256": "1g9c9n36s6sylyynbyc0malrwy0b3x57x6wbgn6n7cpcw9dzzf5m",
#  "hash": "sha256-tbj/W+LssmONfYubfkofC3ieqaqA+WW9p14bbYZNLL0=",
#  "fetchLFS": false,
#  "fetchSubmodules": false,
#  "deepClone": false,
#  "leaveDotGit": false
