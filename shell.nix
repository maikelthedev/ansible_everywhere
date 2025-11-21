{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.ansible          # Ansible itself
    pkgs.python3           # Python 3 interpreter
    pkgs.python3Packages.hvac  # Python hvac library
  ];

  shellHook = ''
    echo "Nix shell ready: Python=$(which python3), Ansible=$(which ansible)"
  '';
}

