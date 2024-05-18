//
//  MainMenuView.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/8/24.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        VStack {
            Text("Cool wifi signal thingy goes here")
        }
        .frame(minWidth: 300, minHeight: 300)
    }
}

#Preview {
    MainMenuView().environmentObject(SharedNetworkData())
}
