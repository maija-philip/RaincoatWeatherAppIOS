//
//  LocationManager.swift
//  FavoritePlaces
//
//  Created by Maija Philip on 10/26/23.
//

import Foundation
import CoreLocation
import SwiftUI

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var location: CLLocation? = nil
    var locationError = false
    var permissionsError = false
    
    override init() {
        super.init()
        
        /**
         run in async task
         this runs it on an already started thread so it doesn't have to create a new one
         this is the best way to do it for asking for permisions
        */
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    } // init
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .notDetermined:
            permissionsError = false
            return
        case .restricted:
            permissionsError = true
            return
        case .denied:
            permissionsError = true
            return
        case .authorizedAlways:
            permissionsError = false
            return
        case .authorizedWhenInUse:
            permissionsError = false
            return
        @unknown default:
            break
        }
    } // did change authorization
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    } // did update location
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = true
    }
    
} // LocationManager
