//
//  ContentScreenHeader.swift
//  WDIW
//
//  Created by Nicolas von Trott on 19.05.24.
//

import SwiftUI

struct ContentScreenHeader: View {
    @EnvironmentObject private var contentScreenVM: ContentScreenViewModel
    let contentCategory: ContentCategories
    
    var body: some View {
        Header(title: contentCategory.getName()) {
            EmptyView()
        } secondaryButton: {
            Button {
                withAnimation {
                    contentScreenVM.toggleSearchField()
                }
            } label: {
                Image(systemName: contentScreenVM.showSearch ? "x.circle.fill" : "magnifyingglass")
                    .bold()
                    .font(.headline)
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
                Image(systemName: "line.3.horizontal.decrease")
                    .bold()
                    .padding(.LeadingM)
                    .contentShape(Rectangle())
            }
        }
    }
}
