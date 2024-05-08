//
//  EditContentSheet.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct EditContentSheet: View {
    @EnvironmentObject private var contentVM: ContentViewModel
    @Environment(\.dismiss) var dismiss
        
    @State var mediaContent: MediaContent
    
    private var contentCategory: ContentCategories {
        ContentCategories.getCategoryFor(mediaContent: mediaContent)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            switch contentCategory {
            case .books:
                AddBookContent(Binding(get: {
                    mediaContent as! Book
                }, set: { book in
                    mediaContent = book
                }))
            case .movies:
                AddBookContent(Binding(get: {
                    mediaContent as! Book
                }, set: { book in
                    mediaContent = book
                }))
            case .series:
                AddBookContent(Binding(get: {
                    mediaContent as! Book
                }, set: { book in
                    mediaContent = book
                }))
            }
            
            Spacer()
        }
    }
}

extension EditContentSheet {
    var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Back")
            }
            
            Spacer()
            
            Group {
                Text("Edit ")
                +
                Text(contentCategory.getSingularName())
            }
            .bold()

            Spacer()
            
            Button {
                switch contentCategory {
                case .books:
                    contentVM.addContent(content: mediaContent as! Book)
                case .movies:
                    contentVM.addContent(content: mediaContent as! Book)
                case .series:
                    contentVM.addContent(content: mediaContent as! Book)
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

extension EditContentSheet {
    private var canSaveContent: Bool {
        switch contentCategory {
        case .books:
            return (mediaContent as! Book).isFilledCompletly
        case .movies:
            return (mediaContent as! Book) == Book.empty
        case .series:
            return (mediaContent as! Book) == Book.empty
        }
    }
}
