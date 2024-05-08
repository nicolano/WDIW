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
    @State var movie = Movie.empty
    @State var series = Series.empty

    var body: some View {
        VStack(spacing: 0) {
            header
            
            switch contentCategory {
            case .books:
                EditBookContent($book)
            case .movies:
                EditMovieContent($movie)
            case .series:
                EditSeriesContent($series)
            }
            
            Spacer()
        }
    }
}

extension AddContentSheet {
    var header: some View {
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
                    contentVM.addContent(content: movie)
                case .series:
                    contentVM.addContent(content: series)
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
            return book.isValid
        case .movies:
            return movie.isValid
        case .series:
            return series.isValid
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
