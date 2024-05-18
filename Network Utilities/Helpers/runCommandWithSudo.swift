//
//  runCommandWithSudo.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/13/24.
//

import Foundation

func runCommandWithSudo(command: String) {
    let appleScript = """
    do shell script "\(command)" with administrator privileges
    """
    
    var error: NSDictionary?
    if let scriptObject = NSAppleScript(source: appleScript) {
        let output = scriptObject.executeAndReturnError(&error)
        if error != nil {
            print("Error: \(error!)")
        } else {
            print("Output: \(String(describing: output.stringValue))")
        }
    }
}

