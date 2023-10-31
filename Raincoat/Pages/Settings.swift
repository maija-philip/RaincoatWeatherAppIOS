//
//  Settings.swift
//  Raincoat
//
//  Created by Maija Philip on 10/31/23.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        Color("Surface")
            .overlay(
            
                VStack (alignment: .leading) {
                    Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("OnSurface"))
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal)
                                        
                    
                } // VStack stay in safe area
                    .padding()
                    .padding()
                    .padding(.top)
                    .padding(.top)
            
            ) // main overlay
            .edgesIgnoringSafeArea(.vertical)
    } // body
}  // settings

#Preview {
    Settings()
}
