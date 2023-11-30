//
//  Message.swift
//  Raincoat
//
//  Created by Maija Philip on 11/25/23.
//

import Foundation

class Message {
    
    var beginning: String
    var middle: String
    var end: String
    var image: String
    
    init(beginning: String, middle: String, end: String, image: String) {
        self.beginning = beginning
        self.middle = middle
        self.end = end
        self.image = image
    }
    
    convenience init() {
        self.init(beginning: "Bring a ", middle: "hoodie", end: " for the morning and evening", image: "scorching.bald")
    }
    
}
