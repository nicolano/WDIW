//
//  AddBook.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct EditBookContent: View {
    @Binding var book: Book

    var body: some View {
        VStack.spacingM {
            CustomTextField(value: $book.name, title: "Name")
            
            CustomTextField(value: $book.author, title: "Author")
                       
            CustomTextField(value: $book.additionalInfo, title: "Additional Informations", lineLimit: 5)
            
            CustomDateField(value: $book.date, title: "Date")
            
            IsFavoriteToggle(value: $book.isFavorite, title: "Favorite")
        }
        .padding(.AllM)
    }
}
