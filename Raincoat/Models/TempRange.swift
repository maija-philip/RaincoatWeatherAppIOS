//
//  TempRange.swift
//  Raincoat
//
//  Created by Maija Philip on 11/9/23.
//

import Foundation


// Describes the temperature with a set of min, max, appropriate garment to prep for the weather and a rain garment
enum TempRange: CaseIterable {
    
    case scorching, hot, warm, cool, cold, frigid, freezing, frozen
    
    // inclusive
//    var minF: Int {
//        switch self {
//        case .scorching:
//            return 90
//        case .hot:
//            return 80
//        case .warm:
//            return 65
//        case .cool:
//            return 50
//        case .cold:
//            return 40
//        case .frigid:
//            return 32
//        case .freezing:
//            return 15
//        case .frozen:
//            return -100
//        }// switch
//    } // min
//    
//    // not inclusive
//    var maxF: Int {
//        switch self {
//        case .scorching:
//            return 200
//        case .hot:
//            return 90
//        case .warm:
//            return 80
//        case .cool:
//            return 65
//        case .cold:
//            return 50
//        case .frigid:
//            return 40
//        case .freezing:
//            return 32
//        case .frozen:
//            return 15
//        }// switch
//    } // max
    
    // inclusive
    var minC: Int {
        switch self {
        case .scorching:
            return 32
        case .hot:
            return 27
        case .warm:
            return 18
        case .cool:
            return 10
        case .cold:
            return 4
        case .frigid:
            return 0
        case .freezing:
            return -9
        case .frozen:
            return -100
        }// switch
    } // min
    
    // not inclusive
    var maxC: Int {
        switch self {
        case .scorching:
            return 100
        case .hot:
            return 32
        case .warm:
            return 27
        case .cool:
            return 18
        case .cold:
            return 10
        case .frigid:
            return 4
        case .freezing:
            return 0
        case .frozen:
            return -9
        }// switch
    } // max
    
    // the garment to prepare for this weather
    var item: String {
        switch self {
        case .scorching:
            return "tanktop"
        case .hot:
            return "light t-shirt"
        case .warm:
            return "t-shirt"
        case .cool:
            return "hoodie"
        case .cold:
            return "coat"
        case .frigid:
            return "coat and a hat"
        case .freezing:
            return "warm coat and a hat"
        case .frozen:
            return "parka"
        } // switch
    } // item
    
    // rain garment appropriate for this weather
    var rainItem: String {
        switch self {
        case .scorching, .hot, .warm, .cool, .cold, .frigid:
            return "raincoat"
        case .freezing, .frozen:
            return "snowcoat"
        } // switch
    } // rain item
    
} // TempRange

