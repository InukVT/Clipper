//
//  ClipperApp.swift
//  Clipper
//
//  Created by Bastian Inuk Christensen on 2022-12-02.
//

import SwiftUI

@main
struct ClipperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
