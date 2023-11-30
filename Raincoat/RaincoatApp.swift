//
//  RaincoatApp.swift
//  Raincoat
//
//  Created by Maija Philip on 10/26/23.
//

import SwiftUI

@main
struct RaincoatApp: App {
    
    // @State private var user = User()
    
    var body: some Scene {
        WindowGroup {
            WelcomeWizardView1() //.environment(user)
                .modelContainer(for: [User.self])
        }
    }
}
