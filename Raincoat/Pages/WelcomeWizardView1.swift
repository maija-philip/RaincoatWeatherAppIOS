//
//  WelcomeWizardView1.swift
//  Raincoat
//
//  Created by Maija Philip on 10/26/23.
//

import SwiftUI
import SwiftData

/// This is the first screen a new user will see when they open the app, it will guide them through getting some basic data of their hair length preference and how they tend to feel hot and cold
struct WelcomeWizardView1: View {
    
    // @Environment(User.self) private var user: User
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    
    @State private var hotCold: Double = 50.0
    @State private var selected: Hairstyle?
    @State private var secondQuestionOpacity: Double = 0.0

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
            
                // Main Content
                NavigationStack {
                    VStack {
                        // Welcome message
                        Text("Welcome to\n\(Text("Raincoat").foregroundStyle(Color("Theme")))")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color("OnSurface"))
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                        
                        /// User chooses their prefered hairstyle, once chosen, the second question appears
                        HairstyleBlock(selected: $selected, secondQuestionOpacity: $secondQuestionOpacity)
                        
                        // Second question + continue button block
                        VStack {
                            // lets user customize how they feel hot and cold temperatures
                            HotColdBlock(hotCold: $hotCold)
                            
                            
                            Spacer()
                            
                            /// Continue button saves their data in the user model
                            NavigationLink(destination: WelcomeWizardView2(isWelcomeWizard: true)) {
                                SolidTextButton(text: "Continue", buttonLevel: .primary)
                            } // navigationLink
                            .simultaneousGesture(TapGesture().onEnded {
                                if user.first != nil {
                                    user[0].hotcold = hotCold
                                    user[0].hair = selected ?? .bald
                                } else {
                                    let newUser = User()
                                    newUser.hotcold = hotCold
                                    newUser.hair = selected ?? .bald
                                    modelContext.insert(newUser)
                                }
                                
                            })
                            .padding()
                        } // VStack - show after hair selected
                        .opacity(secondQuestionOpacity)
                        
                        
                        
                    } // VStack stay in safe area
                        .padding()
                        .padding(.horizontal)
                        .safeAreaPadding()
                        .navigationTitle("")
                } // NavigationStack
                    .tint(Color("OnSurfaceVariant"))
                    
            
            ) // main overlay
            .edgesIgnoringSafeArea(.vertical)
        
    } // body
    
} // WelcomeWizardView1

#Preview {
    MainActor.assumeIsolated {
        WelcomeWizardView1()
            .modelContainer(previewContainer)
    }
    
}

/// Shows the user a slider where they can adjust how they feel hot vs cold
struct HotColdBlock: View {
    
    @Binding var hotCold : Double
    
    var body: some View {
        // Main content
        VStack(alignment: .leading, spacing: 0) {
            // initial question
            Text("Do you tend to run hot or cold?")
                .fontWeight(.medium)
                .foregroundStyle(Color("OnSurface"))
                .font(.title3)
            
            // slider for hot cold
            Slider(value: $hotCold, in: 0...100)
                .padding(.vertical)
                .tint(Color("Theme"))
            
            // text to describe slider
            HStack {
                Text("I feel cold\nusually")
                    .foregroundStyle(Color("OnSurface"))
                
                Spacer()
                
                Text("I feel hot\nusually")
                    .foregroundStyle(Color("OnSurface"))
                    .multilineTextAlignment(.trailing)
            } // HStack
            

        } // VStack
    } // body
} // HotColdBlock


/// Align the hairstyle square blocks together with the hairstyle question, facilitate the picking of a harstyle
struct HairstyleBlock: View {
    
    @Binding var selected: Hairstyle?
    @Binding var secondQuestionOpacity: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Choose a hairstyle")
                .fontWeight(.medium)
                .foregroundStyle(Color("OnSurface"))
                .font(.title3)
            
            HStack {
                SquareBlock(
                    selected: $selected,
                    secondQuestionOpacity: $secondQuestionOpacity,
                    tag: Hairstyle.bald
                )
                SquareBlock(
                    selected: $selected,
                    secondQuestionOpacity: $secondQuestionOpacity,
                    tag: Hairstyle.short
                )
                SquareBlock(
                    selected: $selected, 
                    secondQuestionOpacity: $secondQuestionOpacity,
                    tag: Hairstyle.long
                )
            } // HStack
            .padding(.vertical)
            
        } // VStack

    } // body
} // HairstyleBlock

struct SquareBlock: View {
    
    @Binding var selected: Hairstyle?
    @Binding var secondQuestionOpacity: Double
    @State var tag: Hairstyle
    
    
    var body: some View {
        Button(action: {
            selected = tag
            if secondQuestionOpacity == 0 {
                withAnimation(.easeIn(duration: 0.5)) {
                    secondQuestionOpacity = 1
                }
            }
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
                    .overlay(
                        Image("\(tag)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )
            } // geometry reader
            .padding(3)
            .frame(height: 180)
        })
        .tag(tag)
    }
}
