//
//  User.swift
//  Raincoat
//
//  Created by Maija Philip on 11/7/23.
//

import Foundation
import SwiftUI
import SwiftData

/// enum that describes the hair type the user picked
enum Hairstyle: String {
    case bald = "bald"
    case short = "short"
    case long = "long"
}

@Model // automatically conforms to observable, swiftData auto generates an id
/// stores the user's settings in swiftdata
class ModelUser {
    
    /// breaks down the enum to store it as a String in the model
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
    
    /// create a new user from a set of values
    init(hair: Hairstyle, hotcold: Double, skincolor: SkinColor, location: Location, useCelsius: Bool) {
        self.hairNum = hair.rawValue
        self.hotcold = hotcold
        self.skincolor = skincolor
        self.location = location
        self.useCelsius = useCelsius
    }
    
    /// create a default user
    convenience init() {
        self.init(
            hair: .bald,
            hotcold: 50.0,
            skincolor: SkinColor(), // default grey skin
            location: Location(),
            useCelsius: true
        )
        
    } // from nothing
    
    convenience init(location: Location, hair: Hairstyle, hotcold: Double) {
        self.init(
            hair: hair,
            hotcold: hotcold,
            skincolor: SkinColor(), // default grey skin
            location: location,
            useCelsius: true
        )
        
    } // location, hair, hotcold
    
    convenience init(tempUser: TempUser) {
        self.init(
            hair: tempUser.hair,
            hotcold: tempUser.hotcold,
            skincolor: tempUser.skincolor,
            location: tempUser.location,
            useCelsius: tempUser.useCelsius
        )
        
    } // from temp user
    
    // store user data when updated
}


class TempUser {
    
    var hair: Hairstyle
    var hotcold: Double // from 0 to 100
    var skincolor: SkinColor
    var location: Location
    var useCelsius: Bool
    
    /// create a new user from a set of values
    init(hair: Hairstyle, hotcold: Double, location: Location, skincolor: SkinColor, useCelsius: Bool) {
        self.hair = hair
        self.hotcold = hotcold
        self.skincolor = skincolor
        self.location = location
        self.useCelsius = useCelsius
    }
    
    /// create a default user
    convenience init() {
        self.init(
            hair: .bald,
            hotcold: 50.0,
            location: Location(),
            skincolor: SkinColor(),
            useCelsius: true
        )
    } // from nothing
    
    convenience init(modelUser: ModelUser) {
        self.init(
            hair: modelUser.hair,
            hotcold: modelUser.hotcold,
            location: modelUser.location,
            skincolor: modelUser.skincolor,
            useCelsius: modelUser.useCelsius
        )
    } // from ModelUser

} // TempUser
