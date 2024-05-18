//
//  Network_UtilitiesApp.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/3/24.
//

import SwiftUI
import ServiceManagement

@main
struct Network_UtilitiesApp: App {
    @StateObject public var sharedData = SharedNetworkData()
    @State private var presented = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .inspector(isPresented: $presented) {
                    MainMenuDetailsView()
                        .toolbar {
                            Spacer()
                            Button {
                                presented.toggle()
                            } label: {
                                Label("Toggle Information", systemImage: "info.circle")
                            }
                        }
                        .inspectorColumnWidth(min: 200, ideal: 300, max: 450)
                }
                .environmentObject(sharedData)
        }
        WindowGroup(id: "changemacaddress") {
            ChangeMACAddress()
                .frame(width: 400, height: 600)
                .fixedSize()
                .environmentObject(sharedData)
        }.windowResizability(.contentSize)
        WindowGroup(id: "outputterminal") {
            OutputTerminal()
                .frame(width: 500, height: 500)
                .fixedSize()
        }
    }
}
