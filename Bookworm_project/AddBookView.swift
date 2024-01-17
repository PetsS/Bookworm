//
//  AddBookView.swift
//  Bookworm_project
//
//  Created by Peter Szots on 04/07/2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc // 'moc' stands for 'managed object context' property
    @Environment(\.dismiss) var dismiss // 'dismiss' will dismiss the view when it's called
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var date = Date()
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var hasValidEntry: Bool { // checks if the properties are empty and this bool will be added to the desabled modifier
        if title.isEmpty || author.isEmpty {
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = date
                        
                        try? moc.save()
                        dismiss()
                    }
                    .disabled(hasValidEntry == false) // the button is desabled as long as the condition bool is false
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
