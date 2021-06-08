//
//  ContentView.swift
//  tabletalk-ios
//
//  Created by Nicholas Vanhaute on 6/7/21.
//

import SwiftUI

struct ContentView: View {
    var webSocketManager: WSManager = .init(session: URLSession(configuration: .default))
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
