//
//  HomepageView.swift
//  Raincoat
//
//  Created by Maija Philip on 10/31/23.
//

import SwiftUI
import SwiftData

struct HomepageView: View {
    
    // @Query private var user: [ModelUser]
    @State private var dataModel = DataViewModel()
    @State private var wentToSettingsReload = false
    
    @State var currentSessionUser: TempUser
    
    // create nav appearance
    init () {
        
        // create the UINavigation bar back button appearance
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.backward")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
        UINavigationBar.appearance().titleTextAttributes = .none
        
    } // init
    
    var body: some View {
        NavigationStack {
            Color("Surface")
                .overlay {
                
                    if dataModel.data == nil {
                        VStack {
                            ProgressView()
                                .tint(Color("Theme"))
                        } // VStack
                        
                    } else if dataModel.error {
                        VStack {
                            Text("An error occurred")
                            Text("\(dataModel.errorMessage)")
                                .foregroundStyle(Color("Outline"))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        } // VStack
                        
                    } else {
                        VStack (alignment: .leading) {
                            
                            // Settings button section
                            NavigationLink {
                                SettingsView(hotcold: user[0].hotcold, useCelsius: user[0].useCelsius, hairstyle: user[0].hair, wentToSettingsReload: $wentToSettingsReload)
                            } label: {
                                HStack {
                                    Image(systemName: "gearshape")
                                        .font(.title2)
                                    Text(user[0].location.shortname)
                                }
                                .fontWeight(.medium)
                                .foregroundStyle(Color("OnSurfaceVariant"))
                            } // Navigation Link
                            
                            
                            WeatherDataSection(weather: dataModel.data ?? Weather(), user: user[0])
                            
                            
                            HStack {
                                Spacer()
                                ImageWithSkinBehind(image: dataModel.data?.message.image ?? "cool.\(user[0].hair)")
                                Spacer()
                            } // HStack for Image
                            
                            
                            HStack {
                                Spacer()
                                Text("\( dataModel.data?.message.beginning ?? "Bring a ") \(Text("\(dataModel.data?.message.middle ?? "hoodie") ").foregroundStyle(Color("Theme")))\(dataModel.data?.message.end ?? "  for the morning and evening")")
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color("OnSurface"))
                                    .multilineTextAlignment(.center)
                                Spacer()
                            } // HStack - center bottom text
                            
                            
                        } // VStack stay in safe area
                        .padding()
                        .padding(.horizontal)

                    } // else data error
                
            } // main overlay
            .edgesIgnoringSafeArea(.vertical)
        } // Navigation Stack
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .onAppear() {
            // print("fetching data")
            dataModel.isDone = false
            dataModel.data = nil
            dataModel.fetch(user: user[0])
        } // on Appear
        .onChange(of: wentToSettingsReload) { oldValue, newValue in
            // print("fetching data")
            dataModel.isDone = false
            dataModel.data = nil
            dataModel.fetch(user: user[0])
        }
    } // body
} // HomepageView


#Preview {
    MainActor.assumeIsolated {
        HomepageView()
            .environment(LocationManager())
            .modelContainer(previewContainer)
    }
    
}

struct WeatherDataSection: View {
    
    @State var weather: Weather
    @State var user: ModelUser
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("\(user.useCelsius ? weather.current : Weather.celsiusToFahrenheit(temp: weather.current))°")
                    .font(.system(size: 70))
                    .fontWeight(.black)
                    .foregroundStyle(Color("Theme"))

                HStack {
                    Text("\(user.useCelsius ? weather.min : Weather.celsiusToFahrenheit(temp: weather.min))°")
                        .padding(.trailing)
                    Text("\(user.useCelsius ? weather.max : Weather.celsiusToFahrenheit(temp: weather.max))°")
                } // HStack - Min Max
                .font(.title)
                .foregroundStyle(Color("OnSurface"))
            } // VStack - Temp
            
            Spacer()
            
            VStack{
                Text("\(weather.humidity)%")
                    .font(.title)
                    .foregroundStyle(Color("OnSurface"))
                Text("Humidity")
                    .foregroundStyle(Color("OnSurface"))
            } // VStack - humidy
            .padding(.trailing)
            
            VStack{
                Text("\(weather.rainChance)%")
                    .font(.title)
                    .foregroundStyle(Color("OnSurface"))
                Text(weather.willSnow(user: user) ? "Chance of\nSnow" : "Chance of\nRain")
                    .foregroundStyle(Color("OnSurface"))
                    .multilineTextAlignment(.center)
            } // VStack - humidy
        } // HStack
        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
    } // body
} // Weather Data Section
