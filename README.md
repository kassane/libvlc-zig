<h1 align="center">
  <div>
    <img src=".github/logo.png" alt="libvlc-zig logo"/>
  </div>
</h1>
<p align="center">
    <a href="https://github.com/kassane/libvlc-zig/actions/workflows/Linux.yml">
        <img alt="Build Linux status" src="https://github.com/kassane/libvlc-zig/actions/workflows/Linux.yml/badge.svg">
    </a>
    <a href="https://github.com/kassane/libvlc-zig/actions/workflows/Darwin.yml">
        <img alt="Build MacOS status" src="https://github.com/kassane/libvlc-zig/actions/workflows/Darwin.yml/badge.svg">
    </a>
    <a href="https://opensource.org/licenses/BSD-2-Clause" rel="nofollow">
        <img alt="BSD 2 Clause license" src="https://img.shields.io/github/license/kassane/libvlc-zig"/>
    </a>
    <a href="https://github.com/kassane/libvlc-zig/graphs/contributors">
        <img alt="GitHub contributors" src="https://img.shields.io/github/contributors/kassane/libvlc-zig" />
    </a>
</p>

# libvlc-zig

Zig bindings for libVLC media framework.

## Requirements

- [zig v0.10.0 or higher](https://ziglang.org/download)
- [vlc](https://code.videolan.org/videolan/vlc)

## How to use

### Example

```bash
$> zig build run -DExample="print-version" -Drelease-safe
$> zig build run -DExample="cli-player" -Drelease-safe -- -i /path/multimedia_file
```

## License

```
BSD 2-Clause License

Copyright (c) 2022, Matheus Catarino França

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
```