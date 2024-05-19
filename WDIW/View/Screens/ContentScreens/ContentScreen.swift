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
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @EnvironmentObject private var contentScreenVM: ContentScreenViewModel

    let contentCategory: ContentCategories
    
    var body: some View {
        VStack.zeroSpacing(alignment: .leading) {
            ContentScreenHeader(contentCategory: contentCategory)
            
            if contentScreenVM.contents.isEmpty {
                NoContentSection(contentCategory: .movies)
            } else {
                if contentScreenVM.displayedContents.isEmpty {
                    ProgressView().align(.center)
                } else {
                    List(contentScreenVM.displayedContents.indices, id: \.self) { index in
                        ContentItem(contentScreenVM.displayedContents[index]) {
                            navigationVM.openEditContentSheet(content: contentScreenVM.displayedContents[index])
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(.none)
                        .listRowSpacing(.Spacing.s)
                    }
                    .listStyle(.plain)
                    .safeAreaPadding(.bottom, 100)
                    .searchField(
                        searchQuery: $contentScreenVM.searchQuery,
                        showSearch: contentScreenVM.showSearch
                    )
                }
            }
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}
