# WindowBackdrop

A small macOS SwiftUI utility that places a non-interactive display backdrop behind the active window.

The intended use case is a resized game window such as Minecraft: press Start, click the window you want, and the rest of that display's usable area becomes the chosen background. The backdrop ignores mouse input and follows whichever normal window is active.

## Run

```sh
swift run WindowBackdrop
```

## Build a Dock App

```sh
./scripts/build-app.sh
open WindowBackdrop.app
```

The app bundle appears in the Dock and can be reopened from the Dock while it is running.

## Notes

- The app uses CoreGraphics to list and track visible windows.
- The backdrop is a borderless AppKit window with `ignoresMouseEvents` enabled.
- The backdrop fills the target window's display `visibleFrame`, which excludes the menu bar and Dock.
- Press Start Backdrop, then click any normal window to make it the foreground target.
- macOS does not provide a perfect public API for permanently parenting a window behind another app's window, so the app keeps re-ordering the display backdrop below the active target.
