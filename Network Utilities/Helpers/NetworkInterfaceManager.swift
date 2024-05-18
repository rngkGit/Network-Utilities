//
//  NetworkInterfaceManager.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/13/24.
//

import SwiftUI
import Network

/*class NetworkInterfaceManager: ObservableObject {
    @Published var interfaces: [NetworkInterface] = []

    init() {
        fetchNetworkInterfaces()
    }

    func fetchNetworkInterfaces() {
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        guard getifaddrs(&ifaddr) == 0, let firstAddr = ifaddr else {
            return
        }
        
        var newInterfaces: [NetworkInterface] = []
        
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ptr.pointee
            let name = String(cString: interface.ifa_name)
            
            if let macAddress = getMACAddress(interface: interface) {
                var networkInterface = NetworkInterface(name: name, macAddress: macAddress, ssid: nil)
                if name == "en0" { // Assuming Wi-Fi interface is named "en0"
                    networkInterface.ssid = getSSID()
                }
                
                newInterfaces.append(networkInterface)
            }
        }
        
        freeifaddrs(ifaddr)
        
        DispatchQueue.main.async {
            self.interfaces = newInterfaces
            print(self.interfaces)
        }
    }
    
    private func getMACAddress(interface: ifaddrs) -> String? {
        let addrFamily = interface.ifa_addr.pointee.sa_family
        if addrFamily == UInt8(AF_LINK) {
            var macAddress = ""
            let sdl = interface.ifa_addr.withMemoryRebound(to: sockaddr_dl.self, capacity: 1) { ptr in
                return ptr.pointee
            }

            for index in 0..<Int(sdl.sdl_alen) {
                let byte = Int(sdl.sdl_data.2) + index
                macAddress += String(format: "%02x", byte)
                if index < Int(sdl.sdl_alen) - 1 {
                    macAddress += ":"
                }
            }

            return macAddress
        }
        return nil
    }
    
    private func getSSID() -> String? {
        guard let interface = CWWiFiClient.shared().interface() else {
            return nil
        }
        return interface.ssid()
    }
}*/

/*class NetworkInterfaceManager: ObservableObject {
    @Published var interfaces: [NetworkInterface] = []

    func fetchNetworkInterfaces(showAll: Bool) {
        let task = Process()
        task.launchPath = "/usr/sbin/networksetup"
        task.arguments = ["-listallhardwareports"]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
            interfaces = parseNetworkInterfaces(output, showAll: showAll)
        }
    }

    private func parseNetworkInterfaces(_ output: String, showAll: Bool) -> [NetworkInterface] {
        var interfaces: [NetworkInterface] = []

        let lines = output.components(separatedBy: .newlines)
        var currentInterface: NetworkInterface?

        for line in lines {
            if line.hasPrefix("Hardware Port: ") {
                if let interface = currentInterface {
                    interfaces.append(interface)
                }
                currentInterface = NetworkInterface(name: line.replacingOccurrences(of: "Hardware Port: ", with: ""))
            } else if (showAll || line.contains("Ethernet Address") || line.contains("Wi-Fi")) && currentInterface != nil {
                currentInterface?.macAddress = line.components(separatedBy: " ").last
            }
        }

        if let interface = currentInterface {
            interfaces.append(interface)
        }

        return interfaces.sorted(by: { $0.name < $1.name })
    }
}*/

/*class NetworkInterfaceManager: ObservableObject {
    @Published var interfaces: [NetworkInterface] = []

    func fetchNetworkInterfaces() {
        interfaces = parseNetworkSetup()
    }

    private func parseNetworkSetup() -> [NetworkInterface] {
        var interfaces: [NetworkInterface] = []

        let task = Process()
        task.launchPath = "/usr/sbin/networksetup"
        task.arguments = ["-listallhardwareports"]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
            let lines = output.components(separatedBy: "\n")
            var currentInterface: NetworkInterface?

            for line in lines {
                if line.contains("Hardware Port:") {
                    if let interface = currentInterface {
                        interfaces.append(interface)
                    }
                    currentInterface = NetworkInterface()
                    let components = line.components(separatedBy: ":")
                    if components.count > 1 {
                        currentInterface?.deviceName = components[1].trimmingCharacters(in: .whitespaces)
                    }
                } else if line.contains("Device:") {
                    let components = line.components(separatedBy: ":")
                    if components.count > 1 {
                        currentInterface?.interface = components[1].trimmingCharacters(in: .whitespaces)
                    }
                } else if line.contains("Ethernet Address:") {
                    let components = line.components(separatedBy: ":")
                    if components.count > 1 {
                        currentInterface?.macAddress = components[1].trimmingCharacters(in: .whitespaces)
                    }
                } else if line.contains("Wi-Fi ID:") {
                    let components = line.components(separatedBy: ":")
                    if components.count > 1 {
                        currentInterface?.ssid = components[1].trimmingCharacters(in: .whitespaces)
                    }
                }
            }

            if let interface = currentInterface {
                interfaces.append(interface)
            }
        }

        return interfaces
    }
}*/

/*class NetworkInterfaceManager: ObservableObject {
    @Published var interfaces: [NetworkInterface] = []

    func fetchNetworkInterfaces() {
        interfaces = parseIfconfig()
    }

    private func parseIfconfig() -> [NetworkInterface] {
        var interfaces: [NetworkInterface] = []

        let task = Process()
        task.launchPath = "/sbin/ifconfig"
        task.arguments = ["-a"]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
            let lines = output.components(separatedBy: "\n")
            var currentInterface: NetworkInterface?

            for line in lines {
                if line.hasPrefix("en") || line.hasPrefix("eth") || line.hasPrefix("wl") {
                    if let interface = currentInterface {
                        interfaces.append(interface)
                    }
                    currentInterface = NetworkInterface()
                    currentInterface?.interface = line
                } else if line.contains("ether ") {
                    let components = line.components(separatedBy: " ")
                    if let macIndex = components.firstIndex(of: "ether"), components.indices.contains(macIndex + 1) {
                        currentInterface?.macAddress = components[macIndex + 1]
                    }
                } else if line.contains("inet ") {
                    let components = line.components(separatedBy: " ")
                    if let addressIndex = components.firstIndex(of: "inet"), components.indices.contains(addressIndex + 1) {
                        currentInterface?.ipv4Address = components[addressIndex + 1]
                    }
                } else if line.contains("inet6 ") {
                    let components = line.components(separatedBy: " ")
                    if let addressIndex = components.firstIndex(of: "inet6"), components.indices.contains(addressIndex + 1) {
                        currentInterface?.ipv6Address = components[addressIndex + 1]
                    }
                }
            }

            if let interface = currentInterface {
                interfaces.append(interface)
            }
        }

        return interfaces
    }
}*/

class NetworkInterfaceManager: ObservableObject {
    @Published var interfaces: [NetworkInterface] = []
    @EnvironmentObject var sharedData: SharedNetworkData
    
    func fetchNetworkInterfaces() {
        interfaces = parseNetworkSetup()
    }
    
    //gets and refreshes the interfaces
    private func parseNetworkSetup() -> [NetworkInterface] {
        var interfaces: [NetworkInterface] = []
        
        // Parse output of networksetup
        let task = Process()
        task.launchPath = "/usr/sbin/networksetup"
        task.arguments = ["-listallhardwareports"]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        
        if let output = output {
            let lines = output.components(separatedBy: "\n")
            
            for line in lines {
                if line.contains("Hardware Port:") {
                    var currentInterface = NetworkInterface()
                    let components = line.components(separatedBy: ":")
                    if components.count > 1 {
                        currentInterface.deviceName = components[1].trimmingCharacters(in: .whitespaces)
                        if (currentInterface.deviceName == "Wi-Fi") {
                            currentInterface.isWiFi = true
                        }
                    }
                    interfaces.append(currentInterface)
                } else if line.contains("Device:") {
                    let components = line.components(separatedBy: ":")
                    if components.count > 1 {
                        //print(components[1].trimmingCharacters(in: .whitespaces))
                        interfaces[interfaces.count - 1].interface = components[1].trimmingCharacters(in: .whitespaces)
                    }
                } else if line.contains("Ethernet Address:") {
                    let components = line.components(separatedBy: ":")
                    if components.count > 1 {
                        interfaces[interfaces.count - 1].hardwareMACAddress = components.dropFirst().joined(separator: ":").trimmingCharacters(in: .whitespaces)
                    }
                }
            }
        }
        
        // Parse output of ifconfig -a for each interface
        for interface in interfaces {
            let task2 = Process()
            task2.launchPath = "/sbin/ifconfig"
            task2.arguments = [interface.interface ?? ""]
            let pipe2 = Pipe()
            task2.standardOutput = pipe2
            task2.launch()
            
            let data2 = pipe2.fileHandleForReading.readDataToEndOfFile()
            let output2 = String(data: data2, encoding: .utf8)
            
            if let output = output2 {
                let lines = output.components(separatedBy: "\n")
                
                for line in lines {
                    if line.contains("ether ") {
                        let components = line.components(separatedBy: " ")
                        if let macAddress = components.last {
                            interfaces[interfaces.firstIndex(where: { $0.interface == interface.interface })!].currentMACAddress = macAddress
                        }
                    }
                }
            }
        }
        
        //Checks for SSID information
        for interface in interfaces {
            if let interfaceName = interface.interface {
                let task2 = Process()
                task2.launchPath = "usr/sbin/networksetup"
                task2.arguments = ["-getairportnetwork", interfaceName]
                let pipe2 = Pipe()
                task2.standardOutput = pipe2
                task2.launch()
                
                let data2 = pipe2.fileHandleForReading.readDataToEndOfFile()
                let output2 = String(data: data2, encoding: .utf8)
                
                if let output = output2 {
                    let lines = output.components(separatedBy: "\n")
                    
                    for line in lines {
                        //print(line)
                        if !line.contains("**") && line.contains(":") {
                            let components = line.components(separatedBy: ":")
                            if components.count > 1 {
                                interfaces[interfaces.firstIndex(where: { $0.interface == interface.interface })!].ssid = components[1].trimmingCharacters(in: .whitespaces)
                            }
                        }
                    }
                }
            }
        }
        return interfaces
    }
}
