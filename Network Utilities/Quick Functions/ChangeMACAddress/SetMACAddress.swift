//
//  SetRandomMAC.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/9/24.
//

import Foundation
import Security
import Cocoa

func setMACAddress(macAddress: String, interface: String) {
    let appleScript = """
    do shell script "\("sudo -S networksetup -setnetworkserviceenabled Wi-Fi off && sleep 1 && sudo -S networksetup -setnetworkserviceenabled Wi-Fi on && sudo -S ifconfig \(interface) ether \(macAddress)")" with administrator privileges
    """
    
    var error: NSDictionary?
    if let scriptObject = NSAppleScript(source: appleScript) {
        let output = scriptObject.executeAndReturnError(&error)
        if error != nil {
            print("Error: \(error!)")
        } else {
            print("Success!")
        }
    }
}
