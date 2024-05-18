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
            headerSection
            
            if contentScreenVM.contents.isEmpty {
                NoContentSection(contentCategory: .movies)
            } else {
                List(contentScreenVM.displayedContents.indices, id: \.self) { index in
//                    if contentScreenVM.showSearch && index == 0 {
//                        CustomTextField(value: .constant(""), hint: "")
//                            .padding(.HorizontalM)
//                            .padding(.TopM)
//                            .opacity(0)
//                    }

                    ContentItem(contentScreenVM.displayedContents[index]) {
                        navigationVM.openEditContentSheet(content: contentScreenVM.displayedContents[index])
                    }
                    .padding(
                        .bottom,
                        index == contentScreenVM.displayedContents.count - 1 ? 100 : 0
                    )
                    .listRowSeparator(.hidden)
                    .listRowInsets(.none)
                    .listRowSpacing(.Spacing.s)
                }
                .listStyle(.plain)
                .searchField(
                    searchQuery: $contentScreenVM.searchQuery,
                    showSearch: contentScreenVM.showSearch
                )
            }
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

extension ContentScreen {
    private var headerSection: some View {
        Header(title: contentCategory.getName()) {
            EmptyView()
        } secondaryButton: {
            Button {
                withAnimation {
                    contentScreenVM.showSearch.toggle()
                }
            } label: {
                Image(systemName: contentScreenVM.showSearch ? "x.circle.fill" : "magnifyingglass")
                    .bold()
                    .transaction { transaction in
                        transaction.animation = .none
                    }
            }
        } primaryButton: {
            Menu {
                Menu("Sort by") {
                    Button {
                        contentScreenVM.sortBy = contentScreenVM.sortBy == .dateReverse ? .dateForward : .dateReverse
                    } label: {
                        if contentScreenVM.sortBy == .dateForward || contentScreenVM.sortBy == .dateReverse {
                            Label("Date", systemImage: contentScreenVM.sortBy == .dateReverse ? "arrow.down" : "arrow.up")
                        } else {
                            Text("Date")
                        }
                    }
                    
                    Button {
                        contentScreenVM.sortBy = contentScreenVM.sortBy == .nameForward ? .nameReverse : .nameForward
                    } label: {
                        if contentScreenVM.sortBy == .nameForward || contentScreenVM.sortBy == .nameReverse {
                            Label("Name", systemImage: contentScreenVM.sortBy == .nameForward ? "arrow.down" : "arrow.up")
                        } else {
                            Text("Name")
                        }
                    }
                    
                    Button {
                        contentScreenVM.sortBy = contentScreenVM.sortBy == .ratingReversed ? .ratingForward : .ratingReversed
                    } label: {
                        if contentScreenVM.sortBy == .ratingForward || contentScreenVM.sortBy == .ratingReversed {
                            Label(contentCategory == .books ? "Favorites" : "Rating", systemImage: contentScreenVM.sortBy == .ratingForward ? "arrow.down" : "arrow.up")
                        } else {
                            Text(contentCategory == .books ? "Favorites" : "Rating")
                        }
                    }
                    
                    if contentCategory == .books {
                        Button {
                            contentScreenVM.sortBy = contentScreenVM.sortBy == .authorForward ? .authorReversed : .authorForward
                        } label: {
                            if contentScreenVM.sortBy == .authorReversed || contentScreenVM.sortBy == .authorForward {
                                Label("Author", systemImage: contentScreenVM.sortBy == .authorForward ? "arrow.down" : "arrow.up")
                            } else {
                                Text("Author")
                            }
                        }
                    }
                }
            } label: {
                Image(systemName: "ellipsis")
                    .bold()
                    .rotationEffect(Angle(degrees: 90))
                    .padding(.LeadingM)
                    .contentShape(Rectangle())
            }
        }
    }
}

