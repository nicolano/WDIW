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
                EditBookContent(Binding(get: {
                    mediaContent as! Book
                }, set: { content in
                    mediaContent = content
                }))
            case .movies:
                EditMovieContent(Binding(get: {
                    mediaContent as! Movie
                }, set: { content in
                    mediaContent = content
                }))
            case .series:
                EditSeriesContent(Binding(get: {
                    mediaContent as! Series
                }, set: { content in
                    mediaContent = content
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
                contentVM.addContent(content: mediaContent)
                dismiss()
            } label: {
                Text("Save")
                    .bold()
            }
            .disabled(!mediaContent.isValid)
        }
        .padding(.Spacing.m)
        .background(Color.Custom.surface)
    }
}
