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
        
    @State var content: MediaContent
    
    private var contentCategory: ContentCategories {
        ContentCategories.getCategoryFor(mediaContent: content)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ContentSheetHeader(title: "Edit", content: content) {
                dismiss()
            } onSave: {
                contentVM.addContent(content: content)
            }
                        
            ContentSwitch(content: $content) { book in
                EditBookContent(book)
            } movieContent: { movie in
                EditMovieContent(movie)
            } seriesContent: { series in
                EditSeriesContent(series)
            }
            
            Spacer()
        }
    }
}
