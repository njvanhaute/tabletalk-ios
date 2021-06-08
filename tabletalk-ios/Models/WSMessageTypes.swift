//
//  WSMessageTypes.swift
//  tabletalk-ios
//
//  Created by Nicholas Vanhaute on 6/8/21.
//

import Foundation

enum WSMessageType: String, Codable {
    // Server to client types
    case handshake
}

struct WSMessageMetadata: Codable {
    let type: WSMessageType
}

struct WSHandshake: Codable {
    let id: UUID
}

