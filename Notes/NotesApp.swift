//
//  NotesApp.swift
//  Notes
//
//  Created by Varun on 12/09/22.
//

import SwiftUI

@main
struct NotesApp: App {
    @StateObject private var notesModel = NotesModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              notesModel.container.viewContext)
        }
    }
}
