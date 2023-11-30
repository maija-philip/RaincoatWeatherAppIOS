//
//  Images.swift
//  Raincoat
//
//  Created by Maija Philip on 11/8/23.
//

import Foundation

class Images {
    
    
    static func getHairstyleImgName(style: Hairstyle) -> String {
        var result = "";
        
        switch style {
        case .bald:
            result = "bald"
            break
        case .short:
            result = "short"
            break
        case .long:
            result = "long"
        }
        
        return result;
    }
    
}
