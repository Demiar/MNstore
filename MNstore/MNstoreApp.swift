//
//  MNstoreApp.swift
//  MNstore
//
//  Created by Алексей on 16.04.2022.
//

import SwiftUI

@main
struct MNstoreApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
