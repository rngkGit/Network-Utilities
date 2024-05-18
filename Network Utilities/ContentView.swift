//
//  ContentView.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/3/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var columnVisibility = NavigationSplitViewVisibility.detailOnly
    
    var body: some View {
        
        NavigationSplitView(columnVisibility: $columnVisibility) {
            DeviceList()
        } detail: {
            HStack {
                //Spacer()
                //MainMenuView()
                Spacer()
                MainMenuRightView()
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(SharedNetworkData())
}
