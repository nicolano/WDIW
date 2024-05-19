//
//  AddBook.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

enum FocusedField {
    case name, author, additionalInfo
}

struct EditBookContent: View {
    @EnvironmentObject private var contentVM: ContentViewModel
    
    @Binding var book: Book

    @FocusState private var focusedField: FocusedField?
    
    @State var predictions: [String] = []
    
    var body: some View {
        VStack.spacingM {
            if focusedField == .name || focusedField == nil {
                CustomTextField(value: $book.name, title: "Name")
                    .focused($focusedField, equals: .name)
            }

            if focusedField == .author || focusedField == nil {
                CustomTextField(value: $book.author, title: "Author")
                    .focused($focusedField, equals: .author)
            }
            
            if focusedField == .additionalInfo || focusedField == nil {
                CustomTextField(value: $book.additionalInfo, title: "Additional Informations", lineLimit: 5)
                    .focused($focusedField, equals: .additionalInfo)
            }

            if focusedField == nil {
                CustomDateField(value: $book.date, title: "Date")
                
                IsFavoriteToggle(value: $book.isFavorite, title: "Favorite")
            }
            
            if focusedField == .author {
                List(0..<predictions.count, id: \.self) { index in
                    Text(predictions[index])
                        .onTapGesture {
                            book.author = predictions[index]
                            focusedField = nil
                        }
//                        .listRowSeparator(.hidden)
                        .listRowInsets(.none)
                        .listRowSpacing(.Spacing.s)
                }
                .listStyle(.plain)
            }
            
            Spacer()
        }
        .padding(.AllM)
        .animation(.smooth, value: focusedField)
        .onChange(of: book.author) { _, newValue in
            predictions = contentVM.books.map({$0.author}).filter { authors in
                authors.localizedCaseInsensitiveContains(book.author)
            }.uniqued()
        }
    }
}
