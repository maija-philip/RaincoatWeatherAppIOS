//
//  Router.swift
//  Raincoat
//
//  Created by Maija Philip on 11/28/23.
//

import SwiftUI
import SwiftData

///  Decide which screen to show user when they enter the app based on if they have stored data or not
struct Router: View {
    
    // model data
    @Query private var user: [User]
    
    // create nav appearance
    init () {
        // create the UINavigation bar back button appearance
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.backward")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
        UINavigationBar.appearance().titleTextAttributes = .none
        
    } // init
    
    var body: some View {
    
        // show the user the homepage if they are a current user or the first page of the welcome wizard if they are a new user
        if user.first != nil {
            VStack {
                Text("user!")
                HomepageView()
                    .navigationTitle("")
            }
        } else {
            VStack {
                Text("no user :(")
                WelcomeWizardView1()
                    .navigationTitle("")
            }
        }
            
            
    } // body
} // Router

#Preview {
    MainActor.assumeIsolated {
        Router()
            .modelContainer(previewContainer)
    }
    
}
