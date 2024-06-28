//
//  BookItem.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct BookItem: View {
    internal init(_ book: Book, onTap: @escaping () -> Void) {
        self.book = book
        self.onTap = onTap
    }
    
    private let book: Book
    private let onTap: () -> Void
    
    var body: some View {
        HStack.spacingS(alignment: .top) {
            VStack.spacingXS(alignment: .leading) {
                Text(book.name)
                    .bold()
                
                Text(book.author)
                    .foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.leading)
            .foregroundStyle(Color.primary)

            Spacer(minLength: 0)
            
            if book.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(Color.yellow)
            }
        }
    }
}

#Preview {
    BookItem(Book.empty) {
        
    }
}
