//
//  ChangeMACAddressLeft.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/17/24.
//

import SwiftUI

struct ChangeMACAddressTop: View {
    @StateObject public var networkManager = NetworkInterfaceManager()
    @EnvironmentObject var sharedData: SharedNetworkData
    
    var body: some View {
        VStack {
            Text("Change MAC Address").font(.largeTitle)
            Text("")
            Text("Network Interface: \(sharedData.selectedInterface)").font(.title)
            Text("Current MAC Address: \(sharedData.currentAddress)").font(.title2)
        }.onAppear() {
            refreshCurrentAddress()
        }.padding()
    }
    
    func refreshCurrentAddress() {
        networkManager.fetchNetworkInterfaces()
        for networkInterface in networkManager.interfaces {
            if networkInterface.interface == sharedData.selectedInterface {
                sharedData.currentAddress = networkInterface.currentMACAddress ?? "unknown"
            }
        }
    }
}

#Preview {
    ChangeMACAddressTop().environmentObject(SharedNetworkData())
}
