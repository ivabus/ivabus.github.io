{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages;
    with rubyPackages; [
      bundler
      nodejs-slim
      bundix
      jekyll
      bundler
      eventmachine
      racc
      em-websocket
      ffi
      json
    ];
}
