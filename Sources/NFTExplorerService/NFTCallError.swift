//
//  File.swift
//  
//
//  Created by Jose Tlacuilo on 22/04/22.
//

import Foundation

public struct NFTCallError: Error {
    public enum NFTCallErrorKind {
        case timedOut
        case streamFailed
        case connectionFailed
    }
    
    public let reason: String?
    public let kind: NFTCallErrorKind
}
