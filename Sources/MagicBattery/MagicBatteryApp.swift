import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var devices: [DeviceInfo] = []
    private var timer: Timer?

    init() {
        refresh()
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.refresh()
            }
        }
    }

    func refresh() {
        devices = BatteryService.getDevices()
    }
}

@main
struct MagicBatteryApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        MenuBarExtra {
            MenuBarView(devices: appState.devices, onRefresh: appState.refresh)
        } label: {
            let label = appState.devices
                .map { "\($0.shortIcon) \($0.batteryLevel)%" }
                .joined(separator: " ")
            if label.isEmpty {
                Label("No Devices", systemImage: "battery.0percent")
            } else {
                Text(label)
            }
        }
        .menuBarExtraStyle(.window)
    }
}
