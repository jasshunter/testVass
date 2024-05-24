//
//  ContentView.swift
//  MovieList
//
//  Created by JASS on 23/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
        }.onAppear() {
            RemoteGateway.basicRequest(url: Constants.popular, body: nil, headers: RemoteGateway.headers, method: .get, successCallback: { data in
            }, errorCallback: { error in }, networkErrorCallback: { error in })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
