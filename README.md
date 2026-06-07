# WindowBackdrop

A small macOS SwiftUI utility that places a non-interactive display backdrop behind the active window.

The intended use case is a resized game window such as Minecraft: press Start, click the window you want, and the rest of that display's usable area becomes the chosen background. The backdrop ignores mouse input and follows whichever normal window is active.

## Features

- Shows up as a regular macOS app in the Dock.
- Press `Start Backdrop`, then click any normal window to make it the active target.
- Covers the rest of the target window's display with a solid color or image.
- Ignores mouse input, so it does not block the target window.
- Follows the active/frontmost window while running.
- Holds the backdrop during desktop/Space transitions instead of flashing closed.
- Optional `Cover Menu Bar` setting.
- Image fit modes:
  - `Keep Aspect Ratio`: keeps the full image visible and fills empty zones with a chosen color.
  - `Keep Aspect Ratio and Fill Screen`: keeps aspect ratio, fills the screen, and crops overflow.
  - `Fit Entire Image (Stretches Image)`: stretches the image to the full backdrop with no empty zones or overflow.
- Opacity and blur controls.

## Requirements

- macOS 14 or later
- Apple developer tools only if using the manual Swift/source build option

## Download

WindowBackdrop has three download options:

1. DMG (recommended)

Download the `.dmg` from the GitHub Releases page, open it, and drag `WindowBackdrop.app` to the Applications folder.

The first time you open WindowBackdrop, macOS may show a security warning. Confirm you want to open the app by going to "Privacy and Security" in System Settings, scrolling down to "Security," and clicking "Open Anyway."

2. Direct `.app` file

Download `WindowBackdrop.app` directly if it is provided in the release, then manually drag it into the Applications folder.

3. Manual source build (requires Apple developer tools)

This option requires Apple developer tools because it builds the app on your Mac. Before using it, install either Xcode or Apple's Command Line Tools.

Download the source `.zip`, unzip it, open Terminal in the folder, and run:

```sh
./scripts/build-app.sh
open WindowBackdrop.app
```

If the compiler is missing, install Apple's Command Line Tools:

```sh
xcode-select --install
```

For Finder double-click use:

- `scripts/build-app.command` rebuilds the app and waits before closing Terminal.
- `scripts/build-and-open.command` rebuilds the app, opens it, and waits before closing Terminal.

## How To Use

1. Open WindowBackdrop.
2. Choose a backdrop color or image.
3. Pick the image fit mode if you selected an image.
4. Adjust opacity, blur, and `Cover Menu Bar` if needed.
5. Click `Start Backdrop`.
6. Click the window you want to keep in front.

Click `Stop Backdrop` to remove the backdrop.

## Notes

- The app uses CoreGraphics to list and track visible windows.
- The backdrop is a borderless AppKit window with `ignoresMouseEvents` enabled.
- The backdrop normally fills the target window's display `visibleFrame`, which excludes the menu bar and Dock.
- Cover Menu Bar expands the backdrop frame into the menu bar area.
- Image Fit has three modes: keep aspect ratio with empty-zone color, keep aspect ratio while filling the screen and cropping overflow, or stretch the image to the full backdrop with no empty zones.
- Press Start Backdrop, then click any normal window to make it the foreground target.
- macOS does not provide a perfect public API for permanently parenting a window behind another app's window, so the app keeps re-ordering the display backdrop below the active target.

## Version 1.0.0

WindowBackdrop v1.0.0 is the first full release.

Release notes:

- Packages WindowBackdrop as a normal macOS app.
- Adds a non-interactive display backdrop behind the active window.
- Adds solid color and image backdrops.
- Adds `Start Backdrop` and `Stop Backdrop`.
- Adds active-window following.
- Adds desktop/Space transition handling to reduce backdrop flashing.
- Adds `Cover Menu Bar`.
- Adds opacity and blur controls.
- Adds image fit modes:
  - `Keep Aspect Ratio`
  - `Keep Aspect Ratio and Fill Screen`
  - `Fit Entire Image (Stretches Image)`
- Adds `Empty Zones` color for `Keep Aspect Ratio`.
