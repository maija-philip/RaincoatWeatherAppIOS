//
//  HomepageView.swift
//  Raincoat
//
//  Created by Maija Philip on 10/31/23.
//

import SwiftUI
import SwiftData

struct HomepageView: View {
    // @Environment(User.self) private var user: User
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    @State private var dataModel = DataViewModel()
    
    // create nav appearance
    init () {
        // create the UINavigation bar back button appearance
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.backward")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
        UINavigationBar.appearance().titleTextAttributes = .none
        
    } // init
    
    var body: some View {
        Color("Surface")
            .overlay(
                NavigationStack {
                    if dataModel.data == nil {
                        VStack {
                            ProgressView()
                                .tint(Color("Theme"))
                        } // VStack

                    } else {
                        VStack (alignment: .leading) {
                            // Settings button section
                            NavigationLink {
                                SettingsView(hotcold: user[0].hotcold, useCelsius: user[0].useCelsius, hairstyle: user[0].hair)
                            } label: {
                                HStack {
                                    Image(systemName: "gearshape")
                                        .font(.title2)
                                    Text(user[0].location.shortname)
                                }
                                .fontWeight(.medium)
                                .foregroundStyle(Color("OnSurfaceVariant"))
                            }
                            
                            
                            WeatherDataSection(weather: dataModel.data ?? Weather(), user: user[0])
                            
                            
                            HStack {
                                Spacer()
                                ImageWithSkinBehind(image: dataModel.data?.message.image ?? "cool.\(user[0].hair)")
                                Spacer()
                            }
                            
                            
                            HStack {
                                Spacer()
                                Text("\( dataModel.data?.message.beginning ?? "Bring a ") \(Text("\(dataModel.data?.message.middle ?? "hoodie")").foregroundStyle(Color("Theme")))\(dataModel.data?.message.end ?? " for the morning and evening")")
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color("OnSurface"))
                                    .multilineTextAlignment(.center)
                                Spacer()
                            } // HStack - center bottom text
                                                
                            
                        } // VStack stay in safe area
                            .padding()
                            .padding()
                            .padding(.top)
                    }
                    
                } // Navigation Stack
                    .toolbar(.hidden, for: .navigationBar)
                    .navigationBarBackButtonHidden(true)
                    .navigationTitle("")
                    .onAppear() {
                        print("fetching data")
                        print(user[0])
                        dataModel.isDone = false
                        dataModel.data = nil
                        dataModel.fetch(user: user[0])
                    }
            
            ) // main overlay
            .edgesIgnoringSafeArea(.vertical)
    } // body
} // HomepageView

#Preview {
    MainActor.assumeIsolated {
        HomepageView()
            .modelContainer(previewContainer)
    }
    
}

struct WeatherDataSection: View {
    
    @State var weather: Weather
    @State var user: User
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("\(weather.current)º")
                    .font(.system(size: 70))
                    .fontWeight(.black)
                    .foregroundStyle(Color("Theme"))

                HStack {
                    Text("\(weather.min)º")
                        .padding(.trailing)
                    Text("\(weather.max)º")
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
        }
        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
    }
}
