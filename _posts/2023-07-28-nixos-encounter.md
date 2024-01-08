---
layout: post
summary: "I tried out NixOS this month and it was the best Linux experience I've ever had"
title: "NixOS encounter"
img: /posts_media/2023-07-28-nixos-encounter/screenshot.webp
toc: true
---

## What is NixOS?

[NixOS](https://nixos.org) is a Linux distro based on Nix package manager (wow). Nix (as package manager) provides the ability to create reproducible environments using functional programming language Nix.

Note: Nix could be used without NixOS on generic Linux distros and macOS.

## My first steps in NixOS

### Step one: Installation

I recently got a free (for me) laptop with Astra Linux preinstalled, used it for 10 minutes and caught myself thinking that I could try to install NixOS on it (I had never had experience with NixOS before, until I came across [Delroth's configs](https://github.com/delroth/infra.delroth.net)).

Flashed USB. Booted up. `nixos-generate-config`. `nixos-install`.

#### Encryption

I didn't do a very wise thing by installing NixOS on an encrypted partition (because I've never installed NixOS before), but it didn't bring me any problems, Nix (`nixos-generate-config`) did everything for me (which was a bit surprising).

### Step two: Refactoring configuration

Two-file configuration is good for first time, but Nix provides the ability to split configs into modules that I immediately took advantage of. Initially I thought of using a simple script to deploy systems, that copies configs, but then I learned about Nix flakes and any need to use additional scripts has disappeared.

I created `common/` for common configurations (like Nix (as package manager), laptop and user-specific configs), `roles/` for system roles (like gaming (which installs Wine, Steam and enables 32-bit support in PipeWire and Mesa), development (that installs IDEs and compilers), graphical (that enables my sway configuration) and Yggdrasil (that [configures](https://github.com/ivabus/nixos/blob/master/roles/yggdrasil-client.nix) Yggdrasil to use my private peer, that is also [configured using Nix](https://github.com/ivabus/nixos/blob/master/roles/yggdrasil-peer.nix))) and `machines/` for machine-specific configuration.

### Step three: Configuring more machines

Now, when I have separate modules, I can build a working system just by configuring disks, setting the right hostname and creating machine-specific configs using `nixos-generate-config`.

## Using NixOS

### Config changes

Each time you rebuild NixOS it doesn't affect your previous build and if you do something wrong, you can always roll back to the system with previous configuration.

### GTK things

Setting up GTK themes was a real pain in the ass because I never read the README about the themes and icons I was trying to install :).

### Dotfiles

Currently, I'm installing [my dotfiles](https://github.com/ivabus/dotfiles) using my script, but it doesn't seem a right thing, so I should do something about it (or not, I'm good with it).

## Summary

NixOS is the perfect Linux distribution that I could use as a daily driver. It took only 68 generations to create an ideal habitat for yourself. My configs are available on [GitHub](https://github.com/ivabus/nix).

<img alt="Screenshot with neofetch" src="/posts_media/2023-07-28-nixos-encounter/screenshot.webp"/>

Special thanks to [Delroth](https://delroth.net) for providing the beautiful configuration reference.