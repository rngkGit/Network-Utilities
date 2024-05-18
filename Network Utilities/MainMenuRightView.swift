//
//  MainOptions.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/8/24.
//

import SwiftUI

struct MainMenuRightView: View {
    @Environment(\.openWindow) private var openWindow
    var body: some View {
        VStack {
            Text("Quick Functions").font(.title)
            Button {
                openWindow(id: "changemacaddress")
            } label: {
                Label("Change MAC Address", systemImage: "key.horizontal")
                    .imageScale(.large)
                    .foregroundStyle(.blue)
            }
        }
        .frame(minWidth: 300, minHeight: 300)
    }
}

#Preview {
    MainMenuRightView()
}
