//
//  ContentScreen.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

enum SortBy {
    case dateForward, dateReverse, nameForward, nameReverse, authorForward, authorReversed, ratingForward, ratingReversed
}

struct ContentScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel

    @State private var showSearch: Bool = false
    @State private var searchQuery: String = ""
    @State private var sortBy: SortBy = .dateReverse
    
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
    
    var contentsSorted: [MediaContent] {
        switch sortBy {
        case .dateForward:
            return contentsFiltered.sorted(using: SortDescriptor(\.date, order: .forward))
        case .dateReverse:
            return contentsFiltered.sorted(using: SortDescriptor(\.date, order: .reverse))
        case .nameForward:
            return contentsFiltered.sorted(using: SortDescriptor(\.name, order: .forward))
        case .nameReverse:
            return contentsFiltered.sorted(using: SortDescriptor(\.name, order: .reverse))
        case .authorForward:
            return contentsFiltered.sorted(using: SortDescriptor(\.additionalInfo, order: .forward))
        case .authorReversed:
            return contentsFiltered.sorted(using: SortDescriptor(\.additionalInfo, order: .reverse))
        case .ratingForward:
            return contentsFiltered.sorted(using: SortDescriptor(\.rating, order: .forward))
        case .ratingReversed:
            return contentsFiltered.sorted(using: SortDescriptor(\.rating, order: .reverse))
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
                    
                    ForEach(contentsSorted.indices, id: \.self) { index in
                        ContentItem(contentsSorted[index]) {
                            navigationVM.openEditContentSheet(content: contentsSorted[index])
                        }
                        .padding(.HorizontalM)
                        .padding(.TopS)
                    }
                    .padding(.TopS)
                    
                    Rectangle().fill(Color.clear).frame(height: 100)
                }
                .overlay {
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
                            .align(.top)
                            .transition(ScaleTransition(0, anchor: .top))
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
            EmptyView()
        } secondaryButton: {
            Button {
                withAnimation {
                    showSearch.toggle()
                }
            } label: {
                Image(systemName: showSearch ? "x.circle.fill" : "magnifyingglass")
                    .bold()
                    .transaction { transaction in
                        transaction.animation = .none
                    }
            }
        } primaryButton: {
            Menu {
                Menu("Sort by") {
                    Button {
                        sortBy = sortBy == .dateReverse ? .dateForward : .dateReverse
                    } label: {
                        if sortBy == .dateForward || sortBy == .dateReverse {
                            Label("Date", systemImage: sortBy == .dateReverse ? "arrow.down" : "arrow.up")
                        } else {
                            Text("Date")
                        }
                    }
                    
                    Button {
                        sortBy = sortBy == .nameForward ? .nameReverse : .nameForward
                    } label: {
                        if sortBy == .nameForward || sortBy == .nameReverse {
                            Label("Name", systemImage: sortBy == .nameForward ? "arrow.down" : "arrow.up")
                        } else {
                            Text("Name")
                        }
                    }
                    
                    Button {
                        sortBy = sortBy == .ratingReversed ? .ratingForward : .ratingReversed
                    } label: {
                        if sortBy == .ratingForward || sortBy == .ratingReversed {
                            Label(contentCategory == .books ? "Favorites" : "Rating", systemImage: sortBy == .ratingForward ? "arrow.down" : "arrow.up")
                        } else {
                            Text(contentCategory == .books ? "Favorites" : "Rating")
                        }
                    }
                    
                    if contentCategory == .books {
                        Button {
                            sortBy = sortBy == .authorForward ? .authorReversed : .authorForward
                        } label: {
                            if sortBy == .authorReversed || sortBy == .authorForward {
                                Label("Author", systemImage: sortBy == .authorForward ? "arrow.down" : "arrow.up")
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

