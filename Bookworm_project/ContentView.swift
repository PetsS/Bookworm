//
//  ContentView.swift
//  Bookworm_project
//
//  Created by Peter Szots on 01/07/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    // Fetchrequest is reading out all the books has been saved, load Cora Data information
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title, order: .reverse), //this would sort our data alphabetical by book title reversed from Z to A
        SortDescriptor(\.author) // any number of sorting can be added, it has no performance impact
    ]) var books: FetchedResults<Book>
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .listRowBackground(book.rating < 2 ? Color.red.opacity(0.30) : Color.white) // if the rating is 1, than the background of a list row becomes red
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
            
        }
    }
    
    func deleteBooks(at offsets: IndexSet) { // this method will delete data direcly from FetchRequest, Core Data base
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save() // write the changes out to persistent storage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
