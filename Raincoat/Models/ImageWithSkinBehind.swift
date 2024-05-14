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
    var image: String
    var currentSessionUser: TempUser


    var body: some View {
        ZStack {
            Image(colorScheme == .light ? "\(image).light" : "\(image).dark")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .background(currentSessionUser.skincolor.color)
        .border(Color("Surface"))
        .padding(.bottom)
    }
}
