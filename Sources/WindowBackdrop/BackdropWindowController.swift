import AppKit
import SwiftUI

struct BackdropConfiguration: Equatable {
    var color: NSColor
    var imageURL: URL?
    var opacity: Double
    var blurRadius: Double
    var coverMenuBar: Bool
    var coverDock: Bool
}

@MainActor
final class BackdropWindowController {
    private var window: NSWindow?
    private var lastConfiguration: BackdropConfiguration?

    func show(behind target: TrackedWindow, configuration: BackdropConfiguration) {
        let backdropWindow = window ?? makeWindow()
        let frame = Self.backdropFrame(containingCoreGraphicsFrame: target.frame, configuration: configuration)

        backdropWindow.setFrame(frame, display: true)
        backdropWindow.contentView = NSHostingView(
            rootView: BackdropContentView(configuration: configuration)
                .frame(width: max(frame.width, 1), height: max(frame.height, 1))
        )
        backdropWindow.alphaValue = configuration.opacity

        if !backdropWindow.isVisible {
            backdropWindow.orderFrontRegardless()
        }

        backdropWindow.order(.below, relativeTo: Int(target.id))
        lastConfiguration = configuration
    }

    func close() {
        window?.close()
        window = nil
        lastConfiguration = nil
    }

    private func makeWindow() -> NSWindow {
        let newWindow = NSWindow(
            contentRect: .zero,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        newWindow.backgroundColor = .clear
        newWindow.isOpaque = false
        newWindow.ignoresMouseEvents = true
        newWindow.hasShadow = false
        newWindow.level = .normal
        newWindow.collectionBehavior = [
            .moveToActiveSpace,
            .fullScreenAuxiliary,
            .stationary,
            .ignoresCycle
        ]
        newWindow.isReleasedWhenClosed = false

        window = newWindow
        return newWindow
    }

    private static func backdropFrame(
        containingCoreGraphicsFrame frame: CGRect,
        configuration: BackdropConfiguration
    ) -> CGRect {
        let screen = screen(containingCoreGraphicsFrame: frame)
        let fullFrame = screen.frame
        let visibleFrame = screen.visibleFrame

        var minX = fullFrame.minX
        var minY = fullFrame.minY
        var maxX = fullFrame.maxX
        var maxY = fullFrame.maxY

        if !configuration.coverMenuBar {
            maxY = min(maxY, visibleFrame.maxY)
        }

        if !configuration.coverDock {
            minX = max(minX, visibleFrame.minX)
            minY = max(minY, visibleFrame.minY)
            maxX = min(maxX, visibleFrame.maxX)
        }

        return CGRect(
            x: minX,
            y: minY,
            width: max(maxX - minX, 1),
            height: max(maxY - minY, 1)
        )
    }

    private static func screen(containingCoreGraphicsFrame frame: CGRect) -> NSScreen {
        let matchingScreen = NSScreen.screens.max { left, right in
            intersectionArea(between: left, andCoreGraphicsFrame: frame)
                < intersectionArea(between: right, andCoreGraphicsFrame: frame)
        }

        guard let matchingScreen,
              intersectionArea(between: matchingScreen, andCoreGraphicsFrame: frame) > 0
        else {
            return NSScreen.main ?? NSScreen.screens[0]
        }

        return matchingScreen
    }

    private static func intersectionArea(between screen: NSScreen, andCoreGraphicsFrame frame: CGRect) -> CGFloat {
        guard let displayID = screen.deviceDescription[NSDeviceDescriptionKey("NSScreenNumber")] as? CGDirectDisplayID else {
            return 0
        }

        let intersection = CGDisplayBounds(displayID).intersection(frame)
        guard !intersection.isNull else { return 0 }
        return intersection.width * intersection.height
    }

}

private struct BackdropContentView: View {
    let configuration: BackdropConfiguration

    var body: some View {
        ZStack {
            Color(nsColor: configuration.color)

            if let imageURL = configuration.imageURL,
               let image = NSImage(contentsOf: imageURL) {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFill()
                    .blur(radius: configuration.blurRadius)
            }
        }
        .clipped()
    }
}
