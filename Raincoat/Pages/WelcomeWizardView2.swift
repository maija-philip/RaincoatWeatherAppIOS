//
//  WelcomeWizardView2.swift
//  Raincoat
//
//  Created by Maija Philip on 10/27/23.
//

import SwiftUI
import SwiftData

/**
 Second screen of the Wizard shown to a new user, their skin color is generated from an image they provide
 */
struct WelcomeWizardView2: View {
    
    /// change the image based on dark or light theme so the background matches the screen
    // @Environment(User.self) private var user: User
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // make the save button go back to the settings
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    @State var isWelcomeWizard: Bool
    
    @State private var photo: UIImage? = nil
    
    var body: some View {
        Color("Surface")
            .overlay(
                
                // Main Content
                NavigationStack {
                    VStack {
                        // Title
                        Text("Customize your skin color")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color("OnSurface"))
                            .multilineTextAlignment(.center)
                            .padding()
                            .padding(.horizontal)
                        
                        // Subtitle / Instructions
                        Text("Click below to take an image of a patch of skin for your character")
                            .foregroundStyle(Color("OnSurface"))
                            .multilineTextAlignment(.center)
                            .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                        
                        Spacer()
                        
                        /// Image with background of the generated skin color or a grey template before they have selected
                        ImageWithSkinBehind(image: "skinPicker")
                            
                        
                        Spacer()
                        
                        
                        /// take image button, once first image is taken successfully, turns into less primary
                        NavigationLink {
                            ImagePicker(sourceType: .camera, selectedImage: $photo)
                        } label: {
                            if (photo != nil) {
                                SolidTextButton(text: "Retake Image", buttonLevel: .tertiary)
                            } else {
                                SolidTextButton(text: "Take Image", buttonLevel: .primary)
                            }
                            
                        }
                        
                        /// Continue once an image has been taken
                        if isWelcomeWizard && photo != nil {
                            NavigationLink {
                                HomepageView()
                            } label: {
                                SolidTextButton(text: "Continue", buttonLevel: .primary)
                            }
                        } else if photo != nil {
                            Button {
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                SolidTextButton(text: "Continue", buttonLevel: .primary)
                            }
                            
                        }
                        
                        /// skip for now and leave the skin grey option on welcome wizard
                        if isWelcomeWizard {
                            NavigationLink {
                                HomepageView()
                            } label: {
                                SolidTextButton(text: "Skip for now", buttonLevel: .tertiary)
                            }
                        }
                         
                        
                        
                    } // VStack stay in safe area
                    .padding()
                    .padding()
                    .padding(.top)
                    .padding(.top)
                    .navigationTitle("")
                    .onAppear() {
                        if photo != nil {
                            user[0].skincolor.set(color: photo?.averageColor ?? .gray)
                        }
                    }
                } // Nagivation Stack
                    .tint(Color("OnSurfaceVariant"))
            
            ) // main overlay
            .edgesIgnoringSafeArea(.vertical)
            
    } // body
} // WelcomeWizardView2

#Preview {
    MainActor.assumeIsolated {
        WelcomeWizardView2(isWelcomeWizard: false)
            .modelContainer(previewContainer)
    }
    
}
