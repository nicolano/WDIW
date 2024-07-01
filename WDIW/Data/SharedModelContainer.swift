//
//  SharedModelContainer.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.02.24.
//

import Foundation
import SwiftData

class SharedModelContainer {
    let schema = Schema([
        Book.self, Movie.self, Series.self
    ])
    
    let modelConfiguration: ModelConfiguration
    let modelContainer: ModelContainer
    
    init(isInMemory: Bool, iCloudEnabled: Bool) {
        do {
            modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: isInMemory,
                cloudKitDatabase: iCloudEnabled ?
                    ModelConfiguration.CloudKitDatabase.automatic :
                    ModelConfiguration.CloudKitDatabase.none
            )
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

}
