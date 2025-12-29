---
title: Bundle a Gleam project into an AppImage with Nix
published: true
description: You can turn any package into a single binary using the nix bundle command.
tags: nix, gleam
---

This article is a translation of this [Japanese article](https://comamoca.dev/blog/2025-12-17-build-gleam-erlang-target-to-single-binary-with-nix/).

## nix bundle

Nix has a convenient, albeit unstable, command called `nix bundle`.

https://nix.dev/manual/nix/2.24/command-ref/new-cli/nix3-bundle

This command packages Nix dependencies into a single binary, allowing you to generate a standalone executable.

For example, running the following command will generate a single Python 3.14 binary:

```sh
nix bundle nixpkgs#python314
```

## bundler

By specifying the `--bundler` option, you can change the bundling algorithm.
For instance, specifying `github:ralismark/nix-appimage` allows you to generate a single binary as an AppImage.

https://github.com/ralismark/nix-appimage

To bundle the aforementioned Python 3.14 as an AppImage, you would do the following:

```sh
nix bundle --bundler github:ralismark/nix-appimage nixpkgs#python314
```

Since AppImage works by self-extracting only the necessary files on the fly, it offers faster startup speeds compared to traditional bundling methods. Therefore, using AppImage for bundling is generally recommended.

## Bundling Gleam

Previously, generating a single binary with Gleam required using tools like [garnet](). However, since these rely on Deno and Bun, they were limited to the JavaScript target.

The method introduced here does not depend on the features of the runtime Gleam uses, making it possible to turn Erlang targets into single binaries as well.
I have a trial version available here; running `nix build` should generate a single binary.

https://github.com/Comamoca/sandbox-gleam/tree/main/appimage_build

I used `gleam2nix` to build the Gleam project with Nix.
https://gleam2nix.foxgirl.engineering/

## Summary

- Using `nix bundle` allows you to turn any package into a single binary.
- You can switch the bundling method with the `--bundler` option.
- Using AppImage provides a single binary with fast startup times.
- This also enables single binaries for Gleam projects targeting Erlang.
- It's convenient, but the binary size can become quite large (e.g., several hundred MBs).
