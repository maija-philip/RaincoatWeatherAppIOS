//
//  User.swift
//  Raincoat
//
//  Created by Maija Philip on 11/7/23.
//

import Foundation
import SwiftUI
import SwiftData

enum Hairstyle: String {
    case bald = "bald"
    case short = "short"
    case long = "long"
}

@Model // automatically conforms to observable, swiftData auto generates an id
class User {
    
    // take name priority and rename as priority num, enum value is being stored as a raw value
    // using computed property priority to get enum out of it
    @Attribute(originalName: "hair") var hairNum: Hairstyle.RawValue = Hairstyle.bald.rawValue
    // computed not stored - automatically @Transient
    var hair: Hairstyle {
        get { Hairstyle(rawValue: hairNum) ?? Hairstyle.bald }
        set { hairNum = newValue.rawValue}
    }
    var hotcold: Double // from 0 to 100
    var skincolor: SkinColor
    var location: Location
    var useCelsius: Bool
    
    init(hair: Hairstyle, hotcold: Double, skincolor: SkinColor, location: Location, useCelsius: Bool) {
        self.hairNum = hair.rawValue
        self.hotcold = hotcold
        self.skincolor = skincolor
        self.location = location
        self.useCelsius = useCelsius
    }
    
    convenience init() {
        self.init(
            hair: .bald,
            hotcold: 50.0,
            skincolor: SkinColor(), // default grey skin
            location: Location(),
            useCelsius: true
        )
        
    }
    
    // store user data when updated
}
