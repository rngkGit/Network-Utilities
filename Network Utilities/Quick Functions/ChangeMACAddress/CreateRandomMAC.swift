//
//  CreateRandomMAC.swift
//  Network Utilities
//
//  Created by Keith Beavers on 5/9/24.
//

import Foundation

func createRandomMAC() -> String {
    let task = Process()
    let pipe = Pipe()
    let command = "openssl rand -hex 6 | sed 's/\\(..\\)/\\1:/g; s/:$//'"
    
    task.standardOutput = pipe
    task.standardError = pipe
    
    task.arguments = ["-c" , command]
    task.launchPath = "/bin/zsh"
    
    task.launch()
        
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)
    let clean = output?.replacingOccurrences(of: "\n", with: "") ?? ""
        
    return clean
}
