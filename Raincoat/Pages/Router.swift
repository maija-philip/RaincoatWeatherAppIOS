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
    @Query private var user: [User]
    @State private var locationManager = LocationManager()
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
    
        // show the user the homepage if they are a current user or the first page of the welcome wizard if they are a new user
        if user.first != nil {
            VStack {
                HomepageView()
                    .navigationTitle("")
            }
            .onAppear() {
                if (!locationError && !permissionError && locationManager.location != nil) {
                    user[0].location = Location(mapItem: MKMapItem(placemark: MKPlacemark(coordinate: locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))))
                }
            }
        } else {
            VStack {
                if !locationError && !permissionError && locationManager.location != nil {
                    WelcomeWizardView1()
                        .navigationTitle("")
                        .onAppear() {
                            user[0].location = Location(mapItem: MKMapItem(placemark: MKPlacemark(coordinate: locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))))
                        }
                } else {
                    LocationView(fromSettings: false)
                }
                
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
