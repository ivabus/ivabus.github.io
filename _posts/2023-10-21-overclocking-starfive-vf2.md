---
layout: post
summary: "Up to 1.8 GHz without throttling"
title: "Overclocking StarFive VisionFive 2"
toc: false
---

# TL;DR

Apply a [patch](/posts_media/2023-10-21-overclocking-starfive-vf2/overclock_vf2.patch) to JH7110_VisionFive2_upstream branch of [starfive-tech/linux](https://github.com/starfive-tech/linux). `make -j4; make modules_install; make install; make dtbs_install`. Edit /boot/uEnv.txt `fdtfile` with a proper devicetree path. Profit!

# Introduction

The SiFive U74 frequency in StarFive JH7110 is 1.5 GHz by default, but it can work much better, because even under load the temperature never exceeds 50ºC, so overclocking is worth it. The JH110 can be overclocked to 1.8 GHz, which will be done in this article.

Warning: You are responsible for the safety of your board.

# Prerequisites

- Tree of [starfive-tech/linux](https://github.com/starfive-tech/linux)
- [Patch](/posts_media/2023-10-21-overclocking-starfive-vf2/overclock_vf2.patch)
- Some kind of cooling (just a fan, or with a heat sink)

# Steps

## Apply a patch

```shell
cd linux
git checkout JH7110_VisionFive2_upstream
git apply /path/to/patch/overclock_vf2.patch
```

## Compile the kernel

```shell
make starfive_visionfive2_defconfig
make -j4
```

## Install new kernel

Run as root

```shell
make modules_install
make install
make dtbs_install
```

## Configure bootloader

Your bootloader should be configured to use `starfive/jh7110-starfive-visionfive-2-v1.3b.dtb` devicetree file.

If you are using default Debian option then your `/boot/uEnv.txt` file should look like this

```ini
fdt_high=0xffffffffffffffff
initrd_high=0xffffffffffffffff
kernel_addr_r=0x44000000
kernel_comp_addr_r=0x90000000
kernel_comp_size=0x10000000
fdt_addr_r=0x48000000
ramdisk_addr_r=0x48100000
boot_targets=distro mmc0 dhcp
# Fix wrong fdtfile name
fdtfile=KERNEL_VERSION/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb
# Fix missing bootcmd
bootcmd=run load_distro_uenv;run bootcmd_distro
```

## Reboot and have fun

After you successfully overclocked your VF2, you can ask yourself a question - "can it do better?". [No, it can't](http://forum.rvspace.org/t/how-do-you-overclock-the-vf2/2920/5).