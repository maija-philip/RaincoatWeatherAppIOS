//
//  NavTestView.swift
//  Raincoat
//
//  Created by Maija Philip on 11/3/23.
//

import SwiftUI

struct NavTestView: View {
    var body: some View {
        NavigationStack {
            Text("Hello, World!")
            
            NavigationLink("Go here") {
                HomepageView()
            }
            
            NavigationLink {
                SettingsView(hotcold: 20.0)
            } label: {
                Text("Settings")
            }
            
            NavigationLink("Go Settings") {
                SettingsView(hotcold: 50.0)
            }
            
            NavigationLink {
                WelcomeWizardView1()
            } label: {
                SolidTextButton(text: "Continue", buttonLevel: .primary)
            }
            
            
        }
        
    }
}

#Preview {
    NavTestView()
}
