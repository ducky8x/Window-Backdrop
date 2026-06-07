import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            header

            Button {
                appState.startOrStopBackdrop()
            } label: {
                Label(
                    appState.isBackdropEnabled ? "Stop Backdrop" : "Start Backdrop",
                    systemImage: appState.isBackdropEnabled ? "stop.fill" : "play.fill"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            Form {
                Section("Backdrop") {
                    ColorPicker("Color", selection: $appState.backgroundColor, supportsOpacity: false)

                    HStack {
                        Button {
                            appState.chooseImage()
                        } label: {
                            Label("Choose Image", systemImage: "photo")
                        }

                        if appState.imageURL != nil {
                            Button {
                                appState.clearImage()
                            } label: {
                                Label("Clear", systemImage: "xmark")
                            }
                        }
                    }

                    if let imageURL = appState.imageURL {
                        Text(imageURL.lastPathComponent)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }

                Section("Style") {
                    SliderRow(title: "Opacity", value: $appState.opacity, range: 0.1...1.0, suffix: "")
                    SliderRow(title: "Blur", value: $appState.blurRadius, range: 0...40, suffix: "px")
                }

                Section("Coverage") {
                    Toggle("Cover Menu Bar", isOn: $appState.coverMenuBar)
                    Toggle("Cover Dock", isOn: $appState.coverDock)
                }
            }
            .formStyle(.grouped)

            Spacer(minLength: 0)

            StatusBar(text: appState.status)
        }
        .padding(24)
    }

    private var header: some View {
        HStack(spacing: 14) {
            Image(systemName: appState.isBackdropEnabled ? "scope" : "macwindow")
                .font(.system(size: 34))
                .foregroundStyle(appState.isBackdropEnabled ? .green : .blue)
                .frame(width: 52, height: 52)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(appState.isBackdropEnabled ? "Following Active Window" : "WindowBackdrop")
                    .font(.title2.weight(.semibold))

                if let window = appState.activeWindow {
                    Text("\(window.displayName) - \(window.sizeDescription)")
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                } else {
                    Text("Press Start, then click a window. Everything else on that display is covered.")
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
    }
}

private struct SliderRow: View {
    let title: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let suffix: String

    var body: some View {
        HStack {
            Text(title)
                .frame(width: 80, alignment: .leading)
            Slider(value: $value, in: range)
            Text(label)
                .monospacedDigit()
                .foregroundStyle(.secondary)
                .frame(width: 60, alignment: .trailing)
        }
    }

    private var label: String {
        if suffix.isEmpty {
            return String(format: "%.0f%%", value * 100)
        }
        return "\(Int(value))\(suffix)"
    }
}

private struct StatusBar: View {
    let text: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "info.circle")
            Text(text)
                .lineLimit(2)
            Spacer()
        }
        .foregroundStyle(.secondary)
        .font(.callout)
        .padding(10)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
    }
}
