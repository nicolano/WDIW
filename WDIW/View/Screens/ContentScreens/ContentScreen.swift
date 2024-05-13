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

    @State private var showSearch: Bool = false
    @State private var searchQuery: String = ""

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
    
    var contentsFiltered: [MediaContent] {
        if searchQuery.isEmpty {
            contents
        } else {
            contents.filter { content in
                content.name.localizedCaseInsensitiveContains(searchQuery) ||
                content.additionalInfo.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
    
    var body: some View {
        VStack.zeroSpacing(alignment: .leading) {
            headerSection
            
            if contents.isEmpty {
                NoContentSection(contentCategory: .movies)
            } else {
                ScrollView {
                    if showSearch {
                        CustomTextField(value: $searchQuery, hint: "Search")
                            .padding(.HorizontalM)
                            .padding(.TopM)
                            .opacity(0)
                    }
                    
                    ForEach(contentsFiltered.indices, id: \.self) { index in
                        ContentItem(contentsFiltered[index]) {
                            navigationVM.openEditContentSheet(content: contentsFiltered[index])
                        }
                        .padding(.HorizontalM)
                        .padding(.TopS)
                    }
                    .padding(.TopS)
                }
                .overlay {
                    if showSearch {
                        CustomTextField(value: $searchQuery, hint: "Search", withShadow: true)
                            .padding(.HorizontalM)
                            .padding(.TopM)
                            .align(.top)
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
                withAnimation {
                    showSearch.toggle()
                }
            } label: {
                Image(systemName: showSearch ? "x.circle.fill" : "magnifyingglass")
                    .foregroundStyle(Color.Custom.primary)
                    .bold()
                    .padding(.Spacing.s)
                    .clipShape(Circle())
                    .transaction { transaction in
                        transaction.animation = .none
                    }
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

