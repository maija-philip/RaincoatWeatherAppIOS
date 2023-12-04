//
//  SampleData.swift
//  Raincoat
//
//  Created by Maija Philip on 11/27/23.
//

import Foundation
import SwiftUI
import SwiftData

/// sample user data for the preview
class SampleData {
    static var contents: [User] {
        [
            User()
        ]
    }
} // Sample Data

@MainActor
let previewContainer: ModelContainer = {
    
    do {
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        for item in SampleData.contents {
            container.mainContext.insert(item)
        }
        return container
        
    } catch {
        fatalError("Failed to create container")
    }
    
}() // preview Container
