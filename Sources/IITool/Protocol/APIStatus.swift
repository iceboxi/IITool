//
//  File.swift
//  
//
//  Created by ice on 2021/9/17.
//

import Foundation

public enum APIStatus: Equatable {
    public static func == (lhs: APIStatus, rhs: APIStatus) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.processing, .processing):
            return true
        case (.done(let lhsBool, let lhsString), .done(let rhsBool, let rhsString)):
            return lhsBool == rhsBool && lhsString == rhsString
        default:
            return false
        }
    }
    
    case idle
    case processing
    case done(Bool, String?)
    case other(Any?)
}
