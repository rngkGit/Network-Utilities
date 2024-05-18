//
//  ChangeMACRandomize.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/9/24.
//

import SwiftUI
import CoreWLAN

struct ChangeMACRandomize: View {
    @StateObject public var networkManager = NetworkInterfaceManager()
    @State private var randomizedMACAddress: String = "Please Randomize"
    @State private var ifRandomized: Bool = false
    @EnvironmentObject var sharedData: SharedNetworkData
    
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        VStack {
            Spacer()
            Text("Randomize").font(.title)
            Text("Randomized MAC Address: \(randomizedMACAddress)").font(.title2)
            //Spacer()
            HStack {
                Button {
                    if !ifRandomized {
                        ifRandomized.toggle()
                    }
                    randomizedMACAddress = createRandomMAC()
                } label: {
                    Label("Randomize", systemImage: "wand.and.stars")
                        .imageScale(.large)
                }
                Button {
                    setMACAddress(macAddress: randomizedMACAddress, interface: sharedData.selectedInterface)
                    refreshCurrentAddress()
                } label: {
                    Label("Set", systemImage: "key.horizontal")
                        .imageScale(.large)
                        .foregroundStyle(ifRandomized ? .blue : .gray)
                }.disabled(!ifRandomized)
            }
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
    ChangeMACRandomize().environmentObject(SharedNetworkData())
}
