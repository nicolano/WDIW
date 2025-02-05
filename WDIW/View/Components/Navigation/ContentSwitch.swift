//
//  ContentSwitch.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct ContentSwitch<BookContent: View, MovieContent: View, SeriesContent: View>: View {
    internal init(
        content: Binding<ContentEntry>,
        @ViewBuilder bookContent: @escaping (Binding<ContentEntry>) -> BookContent,
        @ViewBuilder movieContent: @escaping (Binding<ContentEntry>) -> MovieContent,
        @ViewBuilder seriesContent: @escaping (Binding<ContentEntry>) -> SeriesContent
    ) {
        self._contentEntry = content
        self.bookContent = bookContent
        self.movieContent = movieContent
        self.seriesContent = seriesContent
    }
    
    @Binding var contentEntry: ContentEntry
    
    var bookContent: (Binding<ContentEntry>) -> BookContent
    var movieContent: (Binding<ContentEntry>) -> MovieContent
    var seriesContent: (Binding<ContentEntry>) -> SeriesContent
    
    var body: some View {
        switch contentEntry.content?.contentCategory {
        case .books:
            bookContent(
                Binding(get: {
                    contentEntry
                }, set: { newContent in
                    contentEntry = newContent
                })
            )
        case .movies:
            movieContent(
                Binding(get: {
                    contentEntry
                }, set: { newContent in
                    contentEntry = newContent
                })
            )
        case .series:
            seriesContent(
                Binding(get: {
                    contentEntry
                }, set: { newContent in
                    contentEntry = newContent
                })
            )
        default: EmptyView()
        }
    }
}
