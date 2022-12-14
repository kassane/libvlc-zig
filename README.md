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