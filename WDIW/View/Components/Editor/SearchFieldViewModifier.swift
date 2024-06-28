//
//  SearchFieldViewModifier.swift
//  WDIW
//
//  Created by Nicolas von Trott on 18.05.24.
//

import SwiftUI


struct SearchFieldViewModifier: ViewModifier {
    @EnvironmentObject private var contentScreenVM: ContentScreenViewModel

    @FocusState private var isFocused: Bool
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(
                edge: .top,
                content: {
                    if contentScreenVM.showSearch {
                        CustomTextField(
                            value: $contentScreenVM.searchQuery,
                            hint: "Search",
                            withShadow: true,
                            leadingContent: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(Color.secondary)
                            },
                            trailingContent: {
                                if !contentScreenVM.searchQuery.isEmpty {
                                    Button {
                                        contentScreenVM.clearSearchQuery()
                                    } label: {
                                        Image(systemName: "xmark")
                                            .foregroundStyle(Color.secondary)
                                    }
                                }
                            }
                        )
                        .focused($isFocused)
                        .padding(.HorizontalM)
                        .padding(.TopM)
                        .transition(ScaleTransition(0, anchor: .top))
                    }
                }
            )
            .onReceive(contentScreenVM.$isSearchFieldFocused) { output in
                isFocused = output
            }
    }
}

extension View {
    func searchField() -> some View {
        modifier(SearchFieldViewModifier())
    }
}
