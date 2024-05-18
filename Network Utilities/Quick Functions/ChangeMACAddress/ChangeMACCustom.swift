//
//  ChangeMACCustom.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/17/24.
//

import SwiftUI
import CoreWLAN

struct ChangeMACCustom: View {
    @StateObject public var networkManager = NetworkInterfaceManager()
    @EnvironmentObject var sharedData: SharedNetworkData
    @State private var customAddress: String = ""
    
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        VStack {
            Spacer()
            Text("Custom").font(.title)
            TextField("Enter Custom Address Here", text: $customAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 200, height: 10)
            //Spacer()
            HStack {
                Button {
                    setMACAddress(macAddress: customAddress, interface: sharedData.selectedInterface)
                    refreshCurrentAddress()
                } label: {
                    Label("Set", systemImage: "key.horizontal")
                        .imageScale(.large)
                        .foregroundStyle(.blue)
                }
            }.padding()
        }
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
    ChangeMACCustom().environmentObject(SharedNetworkData())
}
