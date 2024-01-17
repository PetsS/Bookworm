//
//  DetailView.swift
//  Bookworm_project
//
//  Created by Peter Szots on 06/07/2022.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var dateFormatter: DateFormatter { // this is to format the date and time
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
            Spacer()
            
            Text("Book added: \(book.date ?? Date.now, formatter: dateFormatter)") // dateFormatter is the computed property
                .font(.caption)
                .foregroundColor(.secondary)
                
        }
        .navigationTitle(book.title ?? "Unknown Title")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        }message: {
            Text("Are you sure?")
        }
        .toolbar{
            Button {
                showingDeleteAlert = true
            }label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() { // delete book from the core database
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
}
