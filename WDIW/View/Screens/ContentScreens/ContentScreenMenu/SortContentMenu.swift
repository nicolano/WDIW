//
//  SortContentMenu.swift
//  WDIW
//
//  Created by Nicolas von Trott on 31.01.25.
//

import SwiftUI

struct SortContentMenu: View {
    @EnvironmentObject private var contentScreenVM: ContentScreenViewModel
    let contentCategory: ContentCategories

    var body: some View {
        Menu {
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
        } label : {
            Label("Sort by", systemImage: "arrow.up.arrow.down")
            Text(sortByDescription(contentScreenVM.sortBy))
        }
    }
}
