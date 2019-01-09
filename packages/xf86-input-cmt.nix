{ stdenv, fetchFromGitHub, pkgconfig, xorgserver, xproto,
  inputproto, utilmacros, libgestures, libevdevc }:

stdenv.mkDerivation rec {
  name = "xf86-input-cmt-${version}";
  version = "2.0.2";
  src = fetchFromGitHub {
    owner = "hugegreenbug";
    repo = "xf86-input-cmt";
    rev = "v${version}";
    sha256 = "1cnwf518nc0ybc1r3rsgc1gcql1k3785khffv0i4v3akrm9wdw98";
  };

  postPatch = ''
    patchShebangs ./apply_patches.sh
    ./apply_patches.sh
  '';

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [
    xorgserver xproto inputproto utilmacros
    libgestures libevdevc
  ];

  configureFlags = [
    "--with-sdkdir=${placeholder "out"}"
  ];
}