//
//  Interface.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/13/24.
//

import Foundation

/*struct NetworkInterface: Identifiable {
    let id = UUID()
    var name: String
    var macAddress: String?
    var ssid: String?

    init(name: String, macAddress: String? = nil, ssid: String? = nil) {
        self.name = name
        self.macAddress = macAddress
        self.ssid = ssid
    }
}*/

struct NetworkInterface: Identifiable {
    let id = UUID()
    var deviceName: String?
    var interface: String?
    var hardwareMACAddress: String?
    var currentMACAddress: String?
    var ssid: String?
    var isWiFi: Bool?

}
