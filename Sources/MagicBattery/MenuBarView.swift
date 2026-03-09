import SwiftUI

struct MenuBarView: View {
    let devices: [DeviceInfo]
    let onRefresh: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if devices.isEmpty {
                Text("No devices found")
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            } else {
                ForEach(devices) { device in
                    HStack(spacing: 10) {
                        Image(systemName: device.icon)
                            .frame(width: 20)
                        Text(device.name)
                        Spacer()
                        Text("\(device.batteryLevel)%")
                            .fontWeight(.medium)
                            .foregroundStyle(device.batteryColor)
                    }
                    .padding(.horizontal)
                }
            }

            Divider()

            HStack {
                Button("Refresh") {
                    onRefresh()
                }
                Spacer()
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
            }
            .padding(.horizontal)
        }
        .frame(width: 260)
        .padding(.vertical, 12)
    }
}
