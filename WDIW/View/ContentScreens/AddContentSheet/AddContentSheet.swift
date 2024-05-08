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
    
    private func getCurrentContent() -> MediaContent {
        switch contentCategory {
        case .books:
            return book
        case .movies:
            return movie
        case .series:
            return series
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            ContentSheetHeader(title: "Add", content: getCurrentContent()) {
                dismiss()
            } onSave: {                    
                contentVM.addContent(content: getCurrentContent())
            }
            
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
