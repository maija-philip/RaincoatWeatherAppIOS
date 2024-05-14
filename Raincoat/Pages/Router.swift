//
//  Router.swift
//  Raincoat
//
//  Created by Maija Philip on 11/28/23.
//

import SwiftUI
import SwiftData
import MapKit

///  Decide which screen to show user when they enter the app based on if they have stored data or not
struct Router: View {
    
    // model data
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [ModelUser]
    @Environment(LocationManager.self) private var locationManager: LocationManager
    
    var locationError : Bool { return locationManager.locationError }
    var permissionError : Bool { return locationManager.permissionsError }
    
    @State var currentSessionUser: TempUser
    @State var hasLocation: Bool = false
    
    // create nav appearance
    init () {
        
        currentSessionUser = user.first != nil ? TempUser(modelUser: user.first) : TempUser()
        
        // create the UINavigation bar back button appearance
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.backward")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
        UINavigationBar.appearance().titleTextAttributes = .none
    
    } // init
    
    
    var body: some View {
    
        VStack {
            // show the user the homepage if they are a current user or the first page of the welcome wizard if they are a new user
            if user.first != nil {
                VStack {
                    HomepageView(currentSessionUser: currentSessionUser)
                        .navigationTitle("")
                } // VStack HomepageView Wrapper

            } else {
                
                WelcomeWizardView1(currentSessionUser: currentSessionUser, isLocationNextScreen: true)
                    .navigationTitle("")
                
            } // else from (if user exists in model)
            
        }
        .onAppear() {
            if (!locationError && !permissionError && locationManager.location != nil) {
                currentSessionUser.location = Location(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0)
                hasLocation = true
            } // if errors
        }
    } // body
} // Router

#Preview {
    MainActor.assumeIsolated {
        Router()
            .environment(LocationManager())
            .modelContainer(previewContainer)
    }
    
}
