//
//  AddBook.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

fileprivate enum FocusedField {
    case name, author, additionalInfo
}

struct EditBookContent: View {
    @EnvironmentObject private var contentVM: ContentViewModel
    
    @Binding var book: Book

    @FocusState private var focusedField: FocusedField?
    
    @State var predictions: [String] = []
    
    var nonFocused: Bool { return self.focusedField == nil }
    
    var body: some View {
        VStack.spacingM {
            if focusedField == .name || nonFocused {
                CustomTextField(value: $book.name, title: "Name")
                    .focused($focusedField, equals: .name)
            }

            if focusedField == .author || nonFocused {
                CustomTextField(value: $book.author, title: "Author")
                    .focused($focusedField, equals: .author)
            }
            
            if focusedField == .additionalInfo || nonFocused {
                CustomTextField(value: $book.additionalInfo, title: "Additional Informations", lineLimit: 5)
                    .focused($focusedField, equals: .additionalInfo)
            }

            if nonFocused {
                CustomDateField(value: $book.date, title: "Date")
                
                IsFavoriteToggle(value: $book.isFavorite, title: "Favorite")
            }
            
            if focusedField == .author {
                PredictionsLists(predictions: predictions) { index in
                    book.author = predictions[index]
                    focusedField = nil
                }
            }
            
            Spacer()
        }
        .padding(.AllM)
        .animation(.smooth, value: focusedField)
        .onChange(of: book.author) { _, newValue in
            predictions = contentVM.books
                .map({$0.author})
                .filter { authors in
                    authors.localizedCaseInsensitiveContains(book.author)
                }
                .uniqued()
        }
    }
}
