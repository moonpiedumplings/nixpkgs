{ lib
, fetchFromGitHub
, rustPlatform
, stdenv
, pkg-config
, libgpg-error
, gpgme
, dbus
, openssl
, Security
}:

rustPlatform.buildRustPackage rec {
  pname = "git-ps-rs";
  version = "6.7.0";

  src = fetchFromGitHub {
    owner = "uptech";
    repo = "git-ps-rs";
    rev = version;
    hash = "sha256-yBZ+YJxiVO8+rI7FLtI0xse8hoirjt5Bc2KxPeBidd0=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "home-dir-0.1.0" = "sha256-k5GYZcR1FI/JEfJhPWOdICBZ9CqJCqX+fYygxxWvFp4=";
    };
  };

  nativeBuildInputs = [
    pkg-config
    gpgme # gpgme runs a small script at build time so has to go here
  ];

  buildInputs = [ openssl dbus libgpg-error gpgme ]
    ++ lib.optionals stdenv.isDarwin [ Security ];

  meta = with lib; {
    description = "Tool for working with a stack of patches";
    homepage = "https://git-ps.sh/";
    license = licenses.mit;
    maintainers = with maintainers; [ alizter ];
  };
}
