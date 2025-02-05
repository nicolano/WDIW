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
    
    @Binding var name: String
    @Binding var author: String
    @Binding var userNotes: String
    @Binding var date: Date
    @Binding var isFavorite: Bool

    @FocusState private var focusedField: FocusedField?
    
    @State var predictions: [String] = []
    
    var nonFocused: Bool { return self.focusedField == nil }
    
    var body: some View {
        VStack.spacingM {
            if focusedField == .name || nonFocused {
                CustomTextField(value: $name, title: "Name")
                    .focused($focusedField, equals: .name)
            }

            if focusedField == .author || nonFocused {
                CustomTextField(value: $author, title: "Author")
                    .focused($focusedField, equals: .author)
            }
            
            if focusedField == .additionalInfo || nonFocused {
                CustomTextField(value: $userNotes, title: "Additional Informations", lineLimit: 5)
                    .focused($focusedField, equals: .additionalInfo)
            }

            if nonFocused {
                CustomDateField(value: $date, title: "Date")
                
                IsFavoriteToggle(value: $isFavorite, title: "Favorite")
            }
            
            if focusedField == .author {
                PredictionsLists(predictions: predictions) { index in
                    author = predictions[index]
                    focusedField = nil
                }
            }
            
            Spacer()
        }
        .padding(.AllM)
        .animation(.smooth, value: focusedField)
        .onChange(of: author) { _, newValue in
            predictions = contentVM.books
                .map({$0.content?.createdBy?.first?.name ?? ""})
                .filter { authors in
                    authors.localizedCaseInsensitiveContains(author)
                }
                .uniqued()
        }
    }
}
