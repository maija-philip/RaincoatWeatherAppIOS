//
//  Location.swift
//  Raincoat
//
//  Created by Maija Philip on 11/13/23.
//

import Foundation
import MapKit
import SwiftData

@Model
class Location {
    var locationName: String
    var shortname: String
    var latitude: Double
    var longitude: Double

    init(mapItem: MKMapItem) {
        self.locationName = mapItem.placemark.title ?? "location"
        self.shortname = mapItem.name ?? "location"
        self.latitude = mapItem.placemark.coordinate.latitude
        self.longitude = mapItem.placemark.coordinate.longitude
    }
    
    convenience init() {
        // sunnyvale, CA
        self.init(mapItem: MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.371428, longitude: -122.038679))))
    }
}

