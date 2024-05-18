//
//  MainMenuDetailsView.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/8/24.
//

import SwiftUI

struct MainMenuDetailsView: View {
    @StateObject public var networkManager = NetworkInterfaceManager()
    @EnvironmentObject var sharedData: SharedNetworkData
    
    var body: some View {
        List {
            ForEach(networkManager.interfaces) { networkInterface in
                if (networkInterface.interface == sharedData.selectedInterface) {
                    Text("Device Name: \(networkInterface.deviceName ?? "N/A")")
                    Text("Interface: \(networkInterface.interface ?? "N/A")")
                    Text("Hardware MAC Address: \(networkInterface.hardwareMACAddress ?? "N/A")")
                    Text("Current MAC Address: \(networkInterface.currentMACAddress ?? "N/A")")
                    Text("SSID: \(networkInterface.ssid ?? "N/A")")
                }
            }
        }.onAppear {
            networkManager.fetchNetworkInterfaces()
        }
    }
}

#Preview {
    MainMenuDetailsView().environmentObject(SharedNetworkData())
}
