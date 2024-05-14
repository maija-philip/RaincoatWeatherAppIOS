//
//  Test.swift
//  Raincoat
//
//  Created by Maija Philip on 12/11/23.
//

import SwiftUI

struct Test: View {
    
    var body: some View {
        VStack {
            Text("Title")
            Text("Subtitle")
                .foregroundStyle(Color("Outline"))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button(action: {
                testWeather()
            }, label: {
                SolidTextButton(text: "Test", buttonLevel: .primary)
            })
        } // VStack
            
    } // body

    func testWeather() {
        
        print("\nBegginging...")
        let weather = Weather()
        //let user = User()
        
        print("Image: \(weather.message.image)")
        print("\(weather.message.beginning) \(weather.message.middle) \(weather.message.end)")
        
        weather.max = 30
        weather.min = 27
        weather.resetTempMessage(user: ModelUser())
        print("\nImage: \(weather.message.image)")
        print("\(weather.message.beginning) \(weather.message.middle) \(weather.message.end)")
        
        weather.min = 20
        weather.resetTempMessage(user: ModelUser())
        print("\nImage: \(weather.message.image)")
        print("\(weather.message.beginning) \(weather.message.middle) \(weather.message.end)")
        
        
        weather.max = 70
        weather.min = 57
        let u = ModelUser()
        u.useCelsius = false
        weather.resetTempMessage(user: u)
        print("\nImage: \(weather.message.image)")
        print("\(weather.message.beginning) \(weather.message.middle) \(weather.message.end)")
    }
    
} // Test


#Preview {
    MainActor.assumeIsolated {
        Test()
            .modelContainer(previewContainer)
    }
}
