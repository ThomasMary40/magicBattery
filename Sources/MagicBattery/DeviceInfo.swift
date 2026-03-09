import SwiftUI

struct DeviceInfo: Identifiable {
    let id: String
    let name: String
    let batteryLevel: Int

    var icon: String {
        let lower = name.lowercased()
        if lower.contains("keyboard") { return "keyboard.fill" }
        if lower.contains("mouse") { return "computermouse.fill" }
        if lower.contains("trackpad") { return "trackpad.fill" }
        return "battery.100percent"
    }

    var shortIcon: String {
        let lower = name.lowercased()
        if lower.contains("keyboard") { return "⌨" }
        if lower.contains("mouse") { return "🖱" }
        if lower.contains("trackpad") { return "▭" }
        return "🔋"
    }

    var batteryColor: Color {
        switch batteryLevel {
        case 0..<20: return .red
        case 20..<50: return .yellow
        default: return .green
        }
    }
}
