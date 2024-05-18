//
//  SearchFieldViewModifier.swift
//  WDIW
//
//  Created by Nicolas von Trott on 18.05.24.
//

import SwiftUI

struct SearchFieldViewModifier: ViewModifier {
    @Binding var searchQuery: String
    let showSearch: Bool
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(
                edge: .top,
                content: {
                    if showSearch {
                        CustomTextField(
                            value: $searchQuery,
                            hint: "Search",
                            withShadow: true,
                            leadingContent: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(Color.secondary)
                            },
                            trailingContent: {
                                if !searchQuery.isEmpty {
                                    Button {
                                        searchQuery.removeAll()
                                    } label: {
                                        Image(systemName: "xmark")
                                            .foregroundStyle(Color.secondary)
                                    }
                                }
                            }
                        )
                        .padding(.HorizontalM)
                        .padding(.TopM)
                        .transition(ScaleTransition(0, anchor: .top))
                    }
                }
            )
    }
}

extension View {
    func searchField(searchQuery: Binding<String>, showSearch: Bool) -> some View {
        modifier(SearchFieldViewModifier(searchQuery: searchQuery, showSearch: showSearch))
    }
}
