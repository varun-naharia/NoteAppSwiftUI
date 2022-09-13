//
//  ContentView.swift
//  Notes
//
//  Created by Varun on 12/09/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var order: Bool = true
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Notes.timestamp, ascending: true)],
        animation: .default)
    private var notes: FetchedResults<Notes>
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { item in
                    NavigationLink {
                        DetailView(note:item)
                    } label: {
                        HStack{
                            Text("\(item.title ?? "")")
                            Spacer()
                            Text("\(item.timestamp ?? Date(), formatter: itemFormatter)")
                        }
                        
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                        Button{
                            sort()
                        }
                    label: {
                        Label("Sort", systemImage: "line.horizontal.3.decrease.circle")
                    }
                        Button {
                            showingAddView.toggle()
                        } label: {
                            Label("Add Note", systemImage: "plus.circle")
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
            .sheet(isPresented: $showingAddView) {
                AddNote(note: nil, noteTitle: "Add")
            }
        }
        .accentColor(Color(.label))
    }
    
    private func sort(){
        order = !order
        if(order){
            self.notes.sortDescriptors = [SortDescriptor(\Notes.timestamp, order: .forward)]
        }
        else{
            self.notes.sortDescriptors = [SortDescriptor(\Notes.timestamp, order: .reverse)]
        }
        
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

