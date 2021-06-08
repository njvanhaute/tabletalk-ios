//
//  WSManager.swift
//  tabletalk-ios
//
//  Created by Nicholas Vanhaute on 6/8/21.
//

import Foundation

class WSManager {
    private let session: URLSession
    var socket: URLSessionWebSocketTask!
    var id: UUID! // ID assigned by backend.
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    init(session: URLSession) {
        self.session = session
        self.socket = session.webSocketTask(with: URL(string: "ws://143.244.145.192:80/tt")!)
        self.listen()
        self.socket.resume()
    }
    
    func listen() {
        self.socket.receive { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let message):
                switch message {
                case .data(let data):
                    self.handle(data)
                case .string(let str):
                    guard let data = str.data(using: .utf8) else { return }
                    self.handle(data)
                @unknown default:
                    break
                }
            }
            self.listen()
        }
    }
    
    func handle(_ data: Data) {
        do {
            let meta = try decoder.decode(WSMessageMetadata.self, from: data)
            switch meta.type {
            case .handshake:
                let message = try decoder.decode(WSHandshake.self, from: data)
                self.id = message.id
                print("Handshake occurred. ID = \(message.id)")
            default:
                break
            }
        } catch {
            print(error)
        }
    }
    
    deinit {
        socket.cancel(with: .normalClosure, reason: nil)
    }
}
