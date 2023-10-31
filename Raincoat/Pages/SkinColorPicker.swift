//
//  SkinColorPicker.swift
//  Raincoat
//
//  Created by Maija Philip on 10/27/23.
//

import SwiftUI

struct SkinColorPicker: View {
    var body: some View {
        Color("Surface")
            .overlay(
            
                VStack {
                    Text("Customize your skin color")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("OnSurface"))
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal)
                    
                    Text("Click below to take an image of a patch of skin for your character")
                        .foregroundColor(Color("OnSurface"))
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                    
                    Spacer()
                    
                    SolidButton(text: "Take Image", buttonLevel: .primary)
                    SolidButton(text: "Skip for now", buttonLevel: .tertiary)
                    
                } // VStack stay in safe area
                .padding()
                .padding()
                .padding(.top)
                .padding(.top)
            
            ) // main overlay
            .edgesIgnoringSafeArea(.vertical)
            
    } // body
} // SkinColorPicker

#Preview {
    SkinColorPicker()
}
