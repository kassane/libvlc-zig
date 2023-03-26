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
    <a href="https://github.com/kassane/libvlc-zig/actions/workflows/MinGW.yml">
        <img alt="Build MinGW status" src="https://github.com/kassane/libvlc-zig/actions/workflows/MinGW.yml/badge.svg">
    </a>
    <a href="https://opensource.org/licenses/BSD-2-Clause" rel="nofollow">
        <img alt="BSD 2 Clause license" src="https://img.shields.io/github/license/kassane/libvlc-zig"/>
    </a>
    <a href="https://github.com/kassane/libvlc-zig/graphs/contributors">
        <img alt="GitHub contributors" src="https://img.shields.io/github/contributors/kassane/libvlc-zig" />
    </a>
</p>

# libvlc-zig

Zig bindings for libVLC media framework. Some of the features provided by libVLC include the ability to play local files and network streams, as well as to transcode media content into different formats. It also provides support for a wide range of codecs, including popular formats like H.264, MPEG-4, and AAC.

## Requirements

- [zig v0.11.0 or higher](https://ziglang.org/download)
- [vlc](https://code.videolan.org/videolan/vlc)

## How to use

### Example

```bash
$> zig build run -Doptimize=ReleaseSafe # print-version (default)
$> zig build run -DExample="cli-player" -Doptimize=ReleaseSafe -- -i /path/multimedia_file
```

## How to contribute to the libvlc-zig project?

Read [Contributing](CONTRIBUTING.md).


## FAQ


### Q: Why isn't libvlc-zig licensed under **LGPLv2.1**?


A: The decision to license `libvlc-zig` under the **BSD-2 clause** was made by the author of the project. This license was chosen because it allows for more permissive use and distribution of the code, while still ensuring that the original author receives credit for their work.

`libvlc-zig` respects the original **LGPLv2.1** (Lesser General Public License) license of the VLC project.


### Q: Are you connected to the developers of the original project?


A: No, the author of `libvlc-zig` is not part of the **VideoLAN development team**. They are simply interested in being part of the VLC community and contributing to its development.


### Q: What is the main goal of this project?


A: The main goal of `libvlc-zig` is to provide a set of bindings for the **VLC media player's** libvlc library that are written in the **Zig programming language**. The project aims to provide a more modern and safe way to interface with the library, while maintaining compatibility with existing code written in **C** and **C++**.


### Q: Does libvlc-zig aim to replace libvlc?


A: No, `libvlc-zig` does not aim to replace libvlc. Instead, it provides an alternative way to interface with the library that may be more suitable for Zig developers.


### Q: Can I use libvlc-zig in my project?


A: Yes, you can use `libvlc-zig` in your project as long as you comply with the terms of the **BSD-2 clause** license. This includes giving credit to the original author of the code.


### Q: Does libvlc-zig support all of the features of libvlc?


A: `libvlc-zig` aims to provide bindings for all of the features of libvlc, but it may not be complete or up-to-date with the latest version of the library. If you encounter any missing features or bugs, please report them to the project's GitHub issues page.


### Q: What programming languages are compatible with libvlc-zig?


A: `libvlc-zig` provides bindings for the **Zig programming language**, but it can also be used with **C** and **C++** projects that use the libvlc library.



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
