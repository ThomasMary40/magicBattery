import Foundation
import IOKit

enum BatteryService {
    static func getDevices() -> [DeviceInfo] {
        var devices: [DeviceInfo] = []

        let matching = IOServiceMatching("AppleDeviceManagementHIDEventService")
        var iterator: io_iterator_t = 0

        let result = IOServiceGetMatchingServices(kIOMainPortDefault, matching, &iterator)
        guard result == KERN_SUCCESS else { return devices }
        defer { IOObjectRelease(iterator) }

        var service = IOIteratorNext(iterator)
        while service != 0 {
            defer {
                IOObjectRelease(service)
                service = IOIteratorNext(iterator)
            }

            guard let batteryRef = IORegistryEntryCreateCFProperty(
                service, "BatteryPercent" as CFString, kCFAllocatorDefault, 0
            )?.takeRetainedValue(),
                  let battery = batteryRef as? Int
            else { continue }

            let name = IORegistryEntryCreateCFProperty(
                service, "Product" as CFString, kCFAllocatorDefault, 0
            )?.takeRetainedValue() as? String ?? "Unknown Device"

            let address = IORegistryEntryCreateCFProperty(
                service, "DeviceAddress" as CFString, kCFAllocatorDefault, 0
            )?.takeRetainedValue() as? String ?? UUID().uuidString

            let transport = IORegistryEntryCreateCFProperty(
                service, "Transport" as CFString, kCFAllocatorDefault, 0
            )?.takeRetainedValue() as? String

            if transport == "Bluetooth" || transport == nil {
                devices.append(DeviceInfo(
                    id: address,
                    name: name,
                    batteryLevel: battery
                ))
            }
        }

        return devices
    }
}
