//
//  FilledButton.swift
//  UIViews
//
//  Created by Maija Philip on 10/12/23.
//

import Foundation
import SwiftUI

/// keep track of the type of button requested
enum ButtonLevel {
    case primary, secondary, tertiary
}

/// creates a custom button to look like the google material ui button that comes in 3 varieties, all in a button element
struct SolidButton: View {
    
    @State var text: String
    @State var symbol: String?
    @State var buttonLevel: ButtonLevel

    var body: some View {
        
        /// the opacity changes depending on which type of button it is.
        let backgroundOpacity = getBackgroundOpacity()


        Button(action: {
            // button action
        }, label: {
            HStack {
                if let symbol {
                    Image(systemName: symbol)
                }
                Text("\(text)")
                    .padding(.horizontal)
                
            } // HStack
            .foregroundStyle(buttonLevel == .primary ? Color("OnTheme") : Color("Theme"))
            .fontWeight(.bold)
            .padding(EdgeInsets(top: 15.0, leading: 25.0, bottom: 15.0, trailing: 25.0))
            .background(
                Capsule()
                    .foregroundStyle(Color("Theme"))
                    .opacity(backgroundOpacity)
            )
        }) // Button
    } // View
    
    /// make the button background invisible, lighter, or fully there depending on button type
    private func getBackgroundOpacity() -> Double {
        var backgroundOpacity = 0.0
        
        switch buttonLevel {
        case .primary:
            backgroundOpacity = 1.0
        case .secondary:
            backgroundOpacity = 0.12
        case .tertiary:
            backgroundOpacity = 0
        }
        
        return backgroundOpacity
    }
} // Solid Button
