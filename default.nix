{ pkgs ? import ./pkgs.nix {} }:
with pkgs;
let cljdeps = import ./deps.nix { inherit pkgs; };
    classp  = cljdeps.makeClasspaths {};

in stdenv.mkDerivation {
  name = "clj-sftp";
  src = ./.;
  buildInputs = [ clojure jre openssl];
  installPhase = ''
      ${clojure}/bin/clojure -i src/clj-sftp/core.clj -Scp ${classp}
  '';
}
