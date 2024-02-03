---
layout: post
summary: "This post is hosted on NixOS"
title: "Hosting Jekyll websites on NixOS"
toc: true
---

## Preamble

Previously this website (ivabus.dev) was hosted on Cloudflare Pages, but recently I learned about NixOS and wanted to host my site "declarative" way.

## The way

### Step 1: Package website

To host website correct way, we want to have its Nix derivation. Before we create one, we have to have `gemset.nix`. To generate one, run this in the root of your Jekyll project

```shell
nix-shell -p bundler -p bundix --run 'bundler update; bundler lock; bundler package --no-install --path vendor; bundix; rm -rf vendor'
```

Note: make sure to remove all the platform-specific gems from `Gemfile` and `Gemfile.lock`, like `google-protobuf`, so your website could be built 

Then you need to create a package for your website with code like this

```nix
{ pkgs ? import <nixpkgs> { }, bundlerEnv ? pkgs.bundlerEnv, ... }:
let
  version = "commit hash";
  repo = builtins.fetchGit {
    url = "https://address/of/git/repo";
    rev = version;
  };

  gems = bundlerEnv {
    name = "your-site";
    ruby = pkgs.ruby;
    gemdir = "${repo}/.";
  };
in pkgs.stdenv.mkDerivation {
  inherit version;
  name = "your-site";
  src = repo;

  buildInputs = with pkgs; [
    gems
    # nokogiri dependencies
    zlib
    libiconv
    libxml2
    libxslt
    # jekyll wants a JS runtime
    nodejs-slim
  ];

  buildPhase = ''
    bundle exec jekyll build 
  '';

  installPhase = ''
    mkdir -p $out
    cp -r _site/* $out/
  '';
}

```

### Step 2: Prepare nginx

```nix
services.nginx = {
  enable = true;
  virtualHosts."your.site" = {
    root = pkgs.callPackage ./path/to/pkg.nix { };
    extraConfig = ''
      error_page 404 /404.html;
    '';
  };
}
```

### Step 3: Rebuild

Rebuild your system and try to visit your website (don't forget to open 80 (and 443, if HTTPS is enabled) ports in the firewall, if needed)
