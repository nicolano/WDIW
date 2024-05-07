//
//  AddContentSheet.swift
//  WDIW
//
//  Created by Nicolas von Trott on 21.02.24.
//

import SwiftUI

struct AddContentSheet: View {
    @EnvironmentObject private var contentVM: ContentViewModel
    @Environment(\.dismiss) var dismiss
    
    let contentCategory: ContentCategories
    
    @State var book = Book.empty
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            switch contentCategory {
            case .books:
                AddBookContent($book)
            case .movies:
                AddBookContent($book)
            case .series:
                AddBookContent($book)
            }
            
            Spacer()
        }
    }
}

extension AddContentSheet {
    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Back")
            }
            
            Spacer()
            
            Group {
                Text("Add ")
                +
                Text(contentCategory.getSingularName())
            }
            .bold()

            Spacer()
            
            Button {
                switch contentCategory {
                case .books:
                    contentVM.addContent(content: book)
                case .movies:
                    contentVM.addContent(content: book)
                case .series:
                    contentVM.addContent(content: book)
                }
                
                dismiss()
            } label: {
                Text("Save")
                    .bold()
            }
            .disabled(!canSaveContent)
        }
        .padding(.Spacing.m)
        .background(Color.Custom.surface)
    }
}

extension AddContentSheet {
    private var canSaveContent: Bool {
        switch contentCategory {
        case .books:
            return book.isFilledCompletly
        case .movies:
            return book == Book.empty
        case .series:
            return book == Book.empty
        }
    }
}

#Preview {
    Rectangle()
        .sheet(isPresented: .constant(true)) {
            AddContentSheet(
                contentCategory: ContentCategories.books
            ) 
        }
}
