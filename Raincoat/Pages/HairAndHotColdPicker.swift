//
//  HairAndHotColdPicker.swift
//  Raincoat
//
//  Created by Maija Philip on 10/26/23.
//

import SwiftUI

struct HairAndHotColdPicker: View {
    
    @State var hotCold: Double = 50.0
    
    var body: some View {
        Color("Surface")
            .overlay(
            
                VStack {
                    Text("Welcome to\n\(Text("Raincoat").foregroundColor(Color("Theme")))")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("OnSurface"))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                    
                    HairstyleBlock()
                    
                    HotColdBlock(hotCold: $hotCold)
                    
                    Spacer()
                    
                    SolidButton(text: "Continue", buttonLevel: .primary)
                    
                } // VStack stay in safe area
                    .padding()
                    .padding([.top, .horizontal])
                    .safeAreaPadding()
            
            ) // main overlay
            .edgesIgnoringSafeArea(.vertical)
        
    } // body
    
} // HairAndHotColdPicker

#Preview {
    HairAndHotColdPicker()
}

struct HotColdBlock: View {
    
    @Binding var hotCold : Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Do you tend to run hot or cold?")
                .foregroundColor(Color("OnSurface"))
                .font(.title3)
            
            Slider(value: $hotCold, in: 0...100)
                .padding(.vertical)
                .tint(Color("Theme"))
            
            HStack {
                Text("I feel cold\nusually")
                    .foregroundColor(Color("OnSurface"))
                
                Spacer()
                
                Text("I feel hot\nusually")
                    .foregroundColor(Color("OnSurface"))
                    .multilineTextAlignment(.trailing)
            } // HStack
            

        } // VStack
    } // body
} // HotColdBlock


struct HairstyleBlock: View {
    
    @State var selected: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Choose a hairstyle")
                .foregroundColor(Color("OnSurface"))
                .font(.title3)
            
            HStack {
                SquareBlock(selected: $selected, tag: 0)
                SquareBlock(selected: $selected, tag: 1)
                SquareBlock(selected: $selected, tag: 2)
            } // HStack
            .padding(.vertical)
            
        } // VStack
        .frame(width: .infinity)

    } // body
} // HairstyleBlock

struct SquareBlock: View {
    
    @Binding var selected: Int?
    @State var tag: Int
    
    var body: some View {
        Button(action: {
            selected = tag
            // action
            
        }, label: {
            GeometryReader { metrics in
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color("ThemeContainer"))
                    .stroke(Color("Theme"), lineWidth: selected == tag ? 6 : 0)
                    .frame(
                        width: metrics.size.width,
                        height: metrics.size.width
                    )
            } // geometry reader
            .padding(3)
            .frame(height: 180)
        })
        .tag(tag)
    }
}
