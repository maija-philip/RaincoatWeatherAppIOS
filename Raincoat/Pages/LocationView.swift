//
//  LocationView.swift
//  Raincoat
//
//  Created by Maija Philip on 11/6/23.
//  With the help of https://kment-robin.medium.com/swiftui-location-search-with-mapkit-c64589990a66
//

import SwiftUI
import SwiftData

struct LocationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // make the save button go back to the settings
    // @Environment(User.self) private var user: User
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]

    
    @State private var background = Color("TextField");
    @StateObject private var viewModel = LocationViewModel()
    @State private var chosenLocation: Location? = nil
    
    var body: some View {
        
        Color("Surface")
            .overlay(
            
                VStack (alignment: .center) {
                    Text("Enter a\nLocation")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundStyle(Color("OnSurface"))
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.top)
                    
                    TextField(user[0].location.shortname, text: $viewModel.cityText)
                        .keyboardType(.default)
                        .padding()
                        .padding(.horizontal)
                        .background(Color("TextField"))
                        .cornerRadius(50)
                        .tint(Color("Theme"))
                        .foregroundStyle(Color("OnSurface"))
                        .padding()
                    
                    List(viewModel.viewData) { item in
                        VStack(alignment: .leading) {
                            Text(item.locationName)
                        }
                        .listRowBackground(Color("Surface"))
                        .padding(.horizontal)
                        .padding()
                        .background(background)
                        .clipShape(Capsule())
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            if (background == Color("TextField")) {
                                background = Color("ThemeContainer")
                            } else {
                                background = Color("TextField")
                            }
                            
                            chosenLocation = item
                            print(item.latitude)
                            print(item.longitude)
                            
                            user[0].location = item
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .listStyle(.plain)
                    
                    
                    
                    Spacer()
                    
                    Button(action: {
                        if (chosenLocation != nil) {
                            user[0].location = chosenLocation ?? Location()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    }, label: {
                        SolidTextButton(text: "Save", buttonLevel: .primary)
                    })
                    
                } // VStack stay in safe area
                    .padding()
                    .padding()
                    .padding(.top)
                    .padding(.top)
                    .navigationTitle("")
            
            ) // main overlay
            .edgesIgnoringSafeArea(.vertical)
        
    } // body
} // LocationView

#Preview {
    MainActor.assumeIsolated {
        LocationView()
            .modelContainer(previewContainer)
    }
}
