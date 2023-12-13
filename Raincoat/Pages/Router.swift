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
    @Query private var user: [User]
    @Environment(LocationManager.self) private var locationManager: LocationManager
    
    var locationError : Bool { return locationManager.locationError }
    var permissionError : Bool { return locationManager.permissionsError }
    
    // create nav appearance
    init () {
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
                    HomepageView()
                        .navigationTitle("")
                } // VStack HomepageView Wrapper
                .onAppear() {

                    if (!locationError && !permissionError && locationManager.location != nil) {
                        user[0].location = Location(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0)
                    } // if errors
                    
                } // on Appear

            } else {
                
                // if there is no locaton error or permission error and we have a location
                if !locationError && !permissionError && locationManager.location != nil {
                    VStack {
                        WelcomeWizardView1(isLocationNextScreen: false, location: Location(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0))
                            .navigationTitle("")
                    } // VStack to wrap WelcomeWizard
                } else {
                    // There is no viable user location
                    WelcomeWizardView1(isLocationNextScreen: true, location: nil)
                        .navigationTitle("")
                } // else location error
                
            } // else from (if user exists in model)
            
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
