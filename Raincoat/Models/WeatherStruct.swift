//
//  WeatherStruct.swift
//  Raincoat
//
//  Created by Maija Philip on 11/9/23.
//

import Foundation


struct WeatherStruct: Codable {
    
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var humidity: Int
 
    
} // WeatherStruct

struct WeatherSectionsStruct: Codable {
    var main: WeatherStruct
    var pop: Double
}

struct WeatherListStruct: Codable {
    var list: [WeatherSectionsStruct]
} // Weather List Struct

/*
 
 API call notes
 
 need lat and long of location
 cnt = 8 // show 24hr worth of data
 mode = metric or imperial
 
 */
