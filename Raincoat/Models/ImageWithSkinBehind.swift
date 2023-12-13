//
//  ImageWithSkinBehind.swift
//  Raincoat
//
//  Created by Maija Philip on 11/18/23.
//

import SwiftUI
import SwiftData

struct ImageWithSkinBehind: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    // @Environment(User.self) private var user: User
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    
    var image: String
    var welcomeUser: WelcomeUser?


    var body: some View {
        ZStack {
            Image(colorScheme == .light ? "\(image).light" : "\(image).dark")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .background(welcomeUser == nil ? user[0].skincolor.color : welcomeUser?.skincolor.color ?? SkinColor().color)
        .padding(.bottom)
    }
}
