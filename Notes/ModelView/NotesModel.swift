//
//  NotesModel.swift
//  Notes
//
//  Created by Varun on 13/09/22.
//

import Foundation
import CoreData

class NotesModel: ObservableObject {
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "Notes")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully.")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addNote(title: String, details: String, context: NSManagedObjectContext) {
        let note = Notes(context: context)
        note.title = title
        note.timestamp = Date()
        note.detail = details
        
        save(context: context)
    }
    
    func editNote(note: Notes,title: String, details: String, context: NSManagedObjectContext) {
        note.title = title
        note.timestamp = Date()
        note.detail = details
        
        save(context: context)
    }
    
}
