//
//  AddBook.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct EditBookContent: View {
    internal init(_ book: Binding<Book>) {
        self._book = book
    }
    
    @Binding var book: Book

    var body: some View {
        VStack.spacingM {
            CustomTextField(value: $book.name, title: "Name")
            
            CustomTextField(value: $book.author, title: "Author")
            
            HStack.spacingM {
                CustomDateField(value: $book.entryDate, title: "Date")

                IsFavoriteToggle(value: $book.isFavorite, title: "Favorite")
            }
            .padding(.TopS)
        }
        .padding(.AllM)
    }
}

#Preview {
    EditBookContent(.constant(Book.empty))
}
