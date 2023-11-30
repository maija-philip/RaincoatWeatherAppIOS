//
//  ContentView.swift
//  Raincoat
//
//  Created by Maija Philip on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                NavigationLink(destination: WelcomeWizardView1()) {
                    Text("Button")
                } // navigationLink
                .padding()
            }
            .padding()
        }
    } // NavigationStack
}

#Preview {
    ContentView()
}
