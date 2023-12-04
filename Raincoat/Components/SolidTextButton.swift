//
//  FilledButton.swift
//  UIViews
//
//  Created by Maija Philip on 10/12/23.
//

import Foundation
import SwiftUI

/// displays a view that looks like a button without a button element to use with navigation links which don't work with button components
/// uses the enum from SolidButton
struct SolidTextButton: View {
    
    @State var text: String
    @State var symbol: String?
    @State var buttonLevel: ButtonLevel

    var body: some View {
        
        /// gets background opacity based on button level
        let backgroundOpacity = getBackgroundOpacity()

        VStack {
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
        }
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
} // SolidTextButton
