//
//  DetailView.swift
//  Notes
//
//  Created by Varun on 13/09/22.
//

import SwiftUI
import CoreData
struct DetailView: View {
    @ObservedObject var note: FetchedResults<Notes>.Element
    @State private var showingAddView = false
    var body: some View {
        VStack{
            Text(note.detail!)
                .multilineTextAlignment(.leading)
                .navigationTitle(note.title!)
                .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddView=true
                } label: {
                    Label("Edit", systemImage: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddNote(note:note, noteTitle:"Edit")
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(note:Notes())
    }
}
