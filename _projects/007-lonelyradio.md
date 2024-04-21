---
layout: project
title: "lonelyradio"
description: "Just For Fun TCP audio streamer"
participant: false
project-url: "https://github.com/ivabus/lonelyradio"
---

Simple audio streaming protocol that allows to stream audio data with metadata.

lonelyradio is an async Rust server that uses [Symphonia](https://github.com/pdeljanov/Symphonia) for audio decoding.

monolib is a client library for playing data from the server (using [rodio](https://crates.io/crates/rodio)). monoclient is a reference implementation of lonelyradio player, that uses monolib for audio playback.

An implementation of app for iOS/iPadOS/macOS is also available.
