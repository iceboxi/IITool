//
//  DataExtension.swift
//  
//
//  Created by ice on 2021/9/3.
//

#if canImport(Foundation)
import Foundation

// MARK: - Properties
public extension Data {
    /// IITool: Print data as hex-string
    var hexDescription: String {
        // or self.reduce("", {$0 + String(format: "%02hhX", $1)})
        return self.map { String(format: "%02hhX", $0) }.joined()
    }
}

#endif
