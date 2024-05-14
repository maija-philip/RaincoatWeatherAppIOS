//
//  SettingsView.swift
//  Raincoat
//
//  Created by Maija Philip on 10/31/23.
//

import SwiftUI
import SwiftData
import MapKit

struct SettingsView: View {
    
    // @Environment(User.self) private var user: User
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [ModelUser]
    @Environment(LocationManager.self) private var locationManager: LocationManager
    
    // params
    @State var currentSessionUser: TempUser
    @Binding var wentToSettingsReload: Bool
    
    @State private var showHairEditSheet = false
    
    var body: some View {
        
        Color("Surface")
            .overlay(
            
                VStack (alignment: .leading) {
                    Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundStyle(Color("OnSurface"))
                        .padding(.vertical)
                    
                    Text("Temperature")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("OnSurface"))
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 5, trailing: 0))
                    HotColdBlock(currentSessionUser: currentSessionUser)
                        .onChange(of: currentSessionUser.hotcold) { oldValue, newValue in
                            user[0].hotcold = currentSessionUser.hotcold
                        }
                    
                    Text("General")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("OnSurface"))
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 5, trailing: 0))
                    
                    // Location
                    NavigationLink {
                        LocationView(fromSettings: true)
                    } label: {
                        RowSettingsButton(title: "Search a Location", value: currentSessionUser.location.shortname)
                    }
                    
                    // Celsius vs Farenheight
                    HStack {
                        
                        Text("Use Celsius")
                            .foregroundStyle(Color("OnSurface"))
                        Spacer()
                        Toggle("", isOn: currentSessionUser.useCelsius)
                            .tint(Color("Theme"))
                            .onChange(of: currentSessionUser.useCelsius) { oldValue, newValue in
                                user[0].useCelsius = currentSessionUser.useCelsius
                            }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                    
                    
                    
                    Text("Looks")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("OnSurface"))
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 5, trailing: 0))
                   
                    // Hair
                    Button {
                        showHairEditSheet = true
                    } label: {
                        RowSettingsButton(
                            title: "Hair",
                            value: "\(currentSessionUser.hair)"
                        ) // action
                    }
                    .sheet(isPresented: $showHairEditSheet, onDismiss: {
                        user[0].hair = currentSessionUser.hair
                    }, content: {
                        HairstyleBlock(selected: $hairstyle, secondQuestionOpacity: .constant(0))
                            .presentationDetents([.medium, .large])
                            .padding()
                    })
                    
                    // Skin
                    NavigationLink {
                        WelcomeWizardView2(isWelcomeWizard: false)
                    } label: {
                        RowSettingsButton(title: "Skin Color", value: "")
                    }
                    
                    
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        if (locationManager.location != nil) {
                            // location exists
                            Button  {
                                user[0].location = Location(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0)
                            } label: {
                                SolidTextButton(text: "Use Current Location", buttonLevel: .secondary)
                            }

                        }
                        Spacer()
                    }
                    .onAppear() {
                        // print("toggled")
                        wentToSettingsReload.toggle()
                    }
                    
                    
                    
                    // DeleteButton()//navigationPath: $navigationPath)
                                        
                    
                } // VStack stay in safe area
                    .padding()
                    .padding()
                    .padding(.top)
                    .padding(.top)
                    .navigationTitle("")
            
            ) // main overlay
            .edgesIgnoringSafeArea(.vertical)
            
    } // body
}  // settings

#Preview {
    MainActor.assumeIsolated {
        SettingsView(hotcold: 50.0, useCelsius: true, wentToSettingsReload: .constant(true))
            .environment(LocationManager())
            .modelContainer(previewContainer)
    }
}
                     
struct RowSettingsButton: View {
    
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            
            Text("\(title)")
                .foregroundStyle(Color("OnSurface"))
            Spacer()
            Text("\(value)")
                .foregroundStyle(Color("OnSurface"))
            Image(systemName: "arrow.right")
                .foregroundStyle(Color("OnSurface"))
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
        
    }
}

struct DeleteButton: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [ModelUser]
    
   //  @Binding var navigationPath: NavigationPath
    
    @State private var showDeleteAlert = false
    @State private var showDeleteFailedAlert = false
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                // show are you sure alert
                showDeleteAlert = true
            }, label: {
                Text("Delete All Data")
                    .foregroundStyle(.red)
            }) // delete account button
            .alert("Are you sure?", isPresented: $showDeleteAlert) {
                
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }
                Button(role: .destructive) {
                    // Handle the deletion.
                    
                    do {
                        try modelContext.delete(model: ModelUser.self)
                        // insertSampleData(modelContext: modelContext)
                        // navigationPath.append("WelcomeWizardView1")
                    } catch {
                        print("failed to delete")
                        showDeleteFailedAlert = true
                    }
                } label: {
                    Text("Delete all data")
                }
                .alert("Data was not able to be deleted, try again", isPresented: $showDeleteFailedAlert) {
                    
                    Button("Ok", role: .cancel) { }
                    
                }
                
            } message: {
                Text("Once you delete your data it can not be recovered")
            }
            Spacer()
        }
    }
}
