//
//  DeviceList.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/9/24.
//

import SwiftUI
import Network
import CoreWLAN

struct DeviceList: View {
    @StateObject public var networkManager = NetworkInterfaceManager()
    @EnvironmentObject var sharedData: SharedNetworkData
    
    var body: some View {
        VStack(alignment: .leading) {
            List(selection: $sharedData.selectedInterface) {
                Section(header: Text("Detected Interfaces")) {
                    ForEach(networkManager.interfaces) { networkInterface in
                        Label(networkInterface.interface ?? "unknown", systemImage: networkInterface.isWiFi ?? false ? "wifi" : "network")
                            .tag(networkInterface.interface ?? "unknown")
                        }
                    }
                }
                .listStyle(SidebarListStyle())
            }
            .onAppear {
                networkManager.fetchNetworkInterfaces()
                if let currentInterface = CWWiFiClient.shared().interface()?.interfaceName {
                    sharedData.selectedInterface = currentInterface
            }
        }
    }
}

#Preview {
    DeviceList().listStyle(.sidebar).environmentObject(SharedNetworkData())
}
