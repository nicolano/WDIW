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
            Group {
                switch ContentCategories.getCategoryFor(mediaContent: content) {
                case .books:
                    BookItem(content as! Book) {
                        onTap()
                    }
                case .movies:
                    BookItem(content as! Book) {
                        onTap()
                    }
                case .series:
                    BookItem(content as! Book) {
                        onTap()
                    }
                }
            }
        }
        .buttonStyle(ContentItemButtonStyle())
    }
}

struct ContentItemButtonStyle: ButtonStyle {
    @State private var animateScale = 1.0
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.AllM)
            .background {
                RoundedRectangle(cornerRadius: .CornerRadius.contentItem)
                    .fill(Material.ultraThin)
            }
            .scaleEffect(animateScale)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                if newValue == true {
                    withAnimation {
                        animateScale = 0.9
                    }
                } else {
                    withAnimation {
                        animateScale = 1.0
                    }
                }
            }
    }
}
