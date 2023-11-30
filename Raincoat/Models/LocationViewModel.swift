//
//  ContentViewModel.swift
//  AppleLocalSearch
//
//  Created by Robin Kment on 13.10.2020.
//  Edited by Maija Philip on 20.11.2023.
//  https://kment-robin.medium.com/swiftui-location-search-with-mapkit-c64589990a66
//
import Foundation
import MapKit
import Combine

final class LocationViewModel: ObservableObject {
    private var cancellable: AnyCancellable?

    @Published var cityText = "" {
        didSet {
            searchForCity(text: cityText)
        }
    }
    
    @Published var viewData = [Location]()

    var service: LocalSearchService
    
    init() {
        // Sunnyvale, CA
        let center = CLLocationCoordinate2D(latitude: 37.3688, longitude: -122.0363)
        service = LocalSearchService(in: center)
        
        cancellable = service.localSearchPublisher.sink { mapItems in
            self.viewData = mapItems.map({ Location(mapItem: $0) })
        }
    }
    
    private func searchForCity(text: String) {
        service.searchCities(searchText: text)
    }

}
