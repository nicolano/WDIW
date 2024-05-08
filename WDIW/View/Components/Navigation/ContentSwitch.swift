//
//  ContentSwitch.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct ContentSwitch<BookContent: View, MovieContent: View, SeriesContent: View>: View {
    internal init(
        content: Binding<MediaContent>,
        @ViewBuilder bookContent: @escaping (Binding<Book>) -> BookContent,
        @ViewBuilder movieContent: @escaping (Binding<Movie>) -> MovieContent,
        @ViewBuilder seriesContent: @escaping (Binding<Series>) -> SeriesContent
    ) {
        self._content = content
        self.bookContent = bookContent
        self.movieContent = movieContent
        self.seriesContent = seriesContent
    }
    
    @Binding var content: MediaContent
    
    var bookContent: (Binding<Book>) -> BookContent
    var movieContent: (Binding<Movie>) -> MovieContent
    var seriesContent: (Binding<Series>) -> SeriesContent
    
    var body: some View {
        switch content {
        case is Book:
            bookContent(
                Binding(get: {
                    content as! Book
                }, set: { newContent in
                    content = newContent
                })
            )
        case is Movie:
            movieContent(
                Binding(get: {
                    content as! Movie
                }, set: { newContent in
                    content = newContent
                })
            )
        case is Series:
            seriesContent(
                Binding(get: {
                    content as! Series
                }, set: { newContent in
                    content = newContent
                })
            )
        default: EmptyView()
        }
    }
}
