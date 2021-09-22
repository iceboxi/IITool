//
//  File.swift
//  
//
//  Created by ice on 2021/9/10.
//

import Foundation

public protocol Model: Codable, Equatable {
    init?(data: Data)
    func encode() -> Data?
}

extension Model {
    public init?(data: Data) {
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            print("Decode Error: \(error)")
            return nil
        }
    }
    
    public func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.encode() == rhs.encode()
    }
}
