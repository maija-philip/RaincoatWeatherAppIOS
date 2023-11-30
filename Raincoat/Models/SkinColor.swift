//
//  SkinColor.swift
//  Raincoat
//
//  Created by Maija Philip on 11/27/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model // automatically conforms to observable, swiftData auto generates an id
class SkinColor {
    
    var color: Color {
        get { Color(UIColor(red: (red/255), green: (green/255), blue: (blue/255), alpha: 1)) }
    }
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    convenience init() {
        self.init(red: 183, green: 183, blue: 183)
    }
    
    func set(color: UIColor) {
    
        red = color.redValue * 255
        green = color.greenValue * 255
        blue = color.blueValue * 255
        
    }
    
}

extension UIColor {
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
}
