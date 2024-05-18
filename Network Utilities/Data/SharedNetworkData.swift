//
//  SharedNetworkData.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/17/24.
//

import Foundation

class SharedNetworkData: ObservableObject {
    @Published var selectedInterface: String = ""
    @Published var currentAddress: String = ""
}
