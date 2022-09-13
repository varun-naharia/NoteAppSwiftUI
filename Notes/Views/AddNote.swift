//
//  AddNote.swift
//  Notes
//
//  Created by Varun on 12/09/22.
//

import SwiftUI
import CoreData

struct AddNote: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    var note: FetchedResults<Notes>.Element?
    @State var title:String = ""
    @State var detail:String = ""
    var noteTitle:String
    

    var body: some View {
        
        VStack {
            Text("\(noteTitle) Note")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.all, 8.0)
            
            TextField("\(note != nil ? note!.title! : "")", text: $title)
                .onAppear(perform: {
                    title = note?.title ?? ""
                    detail = note?.detail ?? ""
                })
                .padding(.all, 8.0)
                .border(Color.gray, width: 1)
            ZStack(alignment: .leading) {
                if detail.isEmpty {
                    Text("Detail")
                        .padding(.all)
                }
                TextEditor(text: $detail)
                    .padding(.all, 8.0)
                    .border(Color.gray, width: 1)
            }
            Spacer()
            HStack{
                Button("Save") {
                    if(note != nil){
                        NotesModel().editNote(note: note!, title: title, details: detail, context: viewContext)
                    }
                    else{
                        NotesModel().addNote(title: title, details: detail,
                            context: viewContext)
                    }
                    dismiss()
                }
                .buttonStyle(.bordered)
                Button("Cancel"){
                    dismiss()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding(.all, 8.0)
    }
}


