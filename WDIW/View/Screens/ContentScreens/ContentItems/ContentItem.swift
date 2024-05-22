//
//  ContentItem.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct ContentItem: View {
    internal init(_ content: MediaContent, onTap: @escaping () -> Void) {
        self.content = content
        self.onTap = onTap
    }
    
    private let content: MediaContent
    private let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            ContentSwitch(content: .constant(content)) { book in
                BookItem(book.wrappedValue) { onTap() }
            } movieContent: { movie in
                MovieItem(movie.wrappedValue) { onTap() }
            } seriesContent: { series in
                SeriesItem(series.wrappedValue) { onTap() }
            }
        }
        .buttonStyle(ContentItemButtonStyle())
    }
}

struct ContentItemButtonStyle: ButtonStyle {    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.AllM)
            .background {
                RoundedRectangle(cornerRadius: .CornerRadius.contentItem)
                    .fill(Material.ultraThin)
            }
    }
}
