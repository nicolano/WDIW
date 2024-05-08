//
//  ContentScreen.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct ContentScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel

    let contentCategory: ContentCategories
    var contents: [MediaContent] {
        switch contentCategory {
        case .books:
            return contentVM.books
        case .movies:
            return contentVM.movies
        case .series:
            return contentVM.series
        }
    }
    
    private func contentView(_ content: MediaContent) -> some View {
        ContentItem(content) {
            navigationVM.openEditContentSheet(content: content)
        }
        .padding(.HorizontalM)
        .padding(.TopS)
    }
    
    var body: some View {
        VStack.zeroSpacing(alignment: .leading) {
            headerSection
            
            if contents.isEmpty {
                NoContentSection(contentCategory: .movies)
            } else {
                ScrollView {
                    switch contentCategory {
                    case .books:
                        ForEach(contents as! [Book], id: \.self) { content in
                            contentView(content)
                        }
                        .padding(.TopS)
                    case .movies:
                        ForEach(contents as! [Movie], id: \.self) { content in
                            contentView(content)
                        }
                        .padding(.TopS)
                    case .series:
                        ForEach(contents as! [Series], id: \.self) { content in
                            contentView(content)
                        }
                        .padding(.TopS)
                    }
                    
                }
            }
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

extension ContentScreen {
    private var headerSection: some View {
        Header(title: contentCategory.getName()) {
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.Custom.primary)
                    .bold()
                    .padding(.Spacing.s)
                    .clipShape(Circle())
            }
        } primaryButton: {
            Button {
                navigationVM.openAddContentSheet(contentCategory: contentCategory)
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(Color.Custom.onPrimary)
                    .padding(.Spacing.s)
                    .background(Color.Custom.primary)
                    .clipShape(Circle())
            }
        }
    }
}

