//
//  Homepage.swift
//  Raincoat
//
//  Created by Maija Philip on 10/31/23.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        Color("Surface")
            .overlay(
            
                VStack (alignment: .leading) {
                    // Settings button section
                    HStack {
                        Image(systemName: "gearshape")
                            .font(.title2)
                        Text("Sunnyvale, CA")
                    }
                    .fontWeight(.medium)
                    .foregroundColor(Color("OnSurfaceVariant"))
                    
                    WeatherDataSection()
                    
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("Bring a \(Text("hoodie").foregroundColor(Color("Theme"))) for the morning and evening")
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(Color("OnSurface"))
                            .multilineTextAlignment(.center)
                        Spacer()
                    } // HStack - center bottom text
                                        
                    
                } // VStack stay in safe area
                    .padding()
                    .padding()
                    .padding(.top)
                    .padding(.top)
            
            ) // main overlay
            .edgesIgnoringSafeArea(.vertical)
    } // body
} // Homepage

#Preview {
    Homepage()
}

struct WeatherDataSection: View {
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("20º")
                    .font(.system(size: 70))
                    .fontWeight(.black)
                    .foregroundColor(Color("Theme"))

                HStack {
                    Text("12º")
                        .padding(.trailing)
                    Text("30º")
                } // HStack - Min Max
                .font(.title)
                .foregroundColor(Color("OnSurface"))
            } // VStack - Temp
            
            Spacer()
            
            VStack{
                Text("87%")
                    .font(.title)
                    .foregroundColor(Color("OnSurface"))
                Text("Humidity")
                    .foregroundColor(Color("OnSurface"))
            } // VStack - humidy
            .padding(.trailing)
            
            VStack{
                Text("0%")
                    .font(.title)
                    .foregroundColor(Color("OnSurface"))
                Text("Chance of\nRain")
                    .foregroundColor(Color("OnSurface"))
                    .multilineTextAlignment(.center)
            } // VStack - humidy
        }
        .padding(.vertical)
    }
}
