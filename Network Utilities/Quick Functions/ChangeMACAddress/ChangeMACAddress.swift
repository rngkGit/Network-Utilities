//
//  ChangeMACAddress.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/9/24.
//

import SwiftUI
import CoreWLAN

struct ChangeMACAddress: View {
    var body: some View {
        VStack {
            ChangeMACAddressTop()
            Spacer()
            ChangeMACRandomize()
            Spacer()
            ChangeMACCustom()
        }
    }
}

#Preview {
    ChangeMACAddress().environmentObject(SharedNetworkData())
}
