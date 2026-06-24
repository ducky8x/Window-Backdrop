# WindowBackdrop

> **This project is archived and no longer maintained. For more updates, check this repository:**
> **(https://github.com/ducky8x/Mac-Speedrunning-Tools**

A small macOS utility that places a non-interactive backdrop behind the active window.

The intended use case is a resized game window such as Minecraft: press **Start Backdrop**, click the window you want, and the rest of that display becomes the chosen background. The backdrop ignores mouse input and follows whichever window is active.

## Features

- Press **Start Backdrop**, click any window to make it the target
- Covers the rest of that display with a solid color or image
- Ignores mouse input, so it never blocks the target window
- Follows the active window while running
- Holds the backdrop during Space/desktop transitions instead of flashing closed
- Optional **Cover Menu Bar** setting
- Image fit modes:
  - **Keep Aspect Ratio** — keeps the full image visible, fills empty zones with a chosen color
  - **Keep Aspect Ratio and Fill Screen** — keeps aspect ratio, fills the screen, crops overflow
  - **Fit Entire Image** — stretches the image to fill the backdrop with no empty zones or cropping
- Opacity and blur controls

## Requirements

- macOS 14 or later

## Download

### 1. DMG (recommended)

Download the `.dmg` from the Releases page, open it, and drag `WindowBackdrop.app` to Applications.

> **First launch:** macOS may show a security warning. Go to **System Settings → Privacy & Security → Security** and click **Open Anyway**.

### 2. Direct `.app`

Download `WindowBackdrop.app` from the release and drag it into Applications.

### 3. Manual source build

Requires Xcode or Apple's Command Line Tools.

Download and unzip the source, open Terminal in the folder, and run:

```sh
./scripts/build-app.sh
open WindowBackdrop.app
```

If the compiler is missing:

```sh
xcode-select --install
```

For Finder use, `scripts/build-app.command` rebuilds and waits, and `scripts/build-and-open.command` rebuilds, opens the app, and waits.

## Usage

1. Open WindowBackdrop.
2. Choose a backdrop color or image.
3. Pick an image fit mode if using an image.
4. Adjust opacity, blur, and **Cover Menu Bar** if needed.
5. Click **Start Backdrop**, then click the window you want in front.

Click **Stop Backdrop** to remove the backdrop.

## Changelog

### v1.0.0
- First full release
- Added solid color and image backdrops
- Added Start/Stop Backdrop
- Added active-window following
- Added Space/desktop transition handling
- Added Cover Menu Bar
- Added opacity and blur controls
- Added image fit modes

## License

Copyright © 2026 ducky8x.

This project is licensed under the GNU GPL v3.0. You're free to use, modify, and distribute this code, but any project that uses it must also be open source and released under the same license. See the [LICENSE](./LICENSE) file for details.
