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
    @State private var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            Router() //.environment(user)
                .environment(locationManager)
                .modelContainer(for: [ModelUser.self])
        }
    }
}
