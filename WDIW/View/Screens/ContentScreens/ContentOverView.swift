//
//  ContentView.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct ContentOverView: View {
    internal init(contentVM: ContentViewModel) {
        self.bookContentScreenViewModel = ContentScreenViewModel(
            contentVM: contentVM,
            contentCategory: .books
        )
        self.moviesContentScreenViewModel = ContentScreenViewModel(
            contentVM: contentVM,
            contentCategory: .movies
        )
        self.seriesContentScreenViewModel = ContentScreenViewModel(
            contentVM: contentVM,
            contentCategory: .series
        )
    }
    
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel
    
    @ObservedObject private var bookContentScreenViewModel: ContentScreenViewModel
    @ObservedObject private var moviesContentScreenViewModel: ContentScreenViewModel
    @ObservedObject private var seriesContentScreenViewModel: ContentScreenViewModel

    @State private var scrollPosition: CGPoint = .zero
    
    var body: some View {
        HStack.zeroSpacing {
            BooksScreen(offset: scrollPosition)
                .id(ContentCategories.books)
                .environmentObject(bookContentScreenViewModel)
            
            ContentScreen(contentCategory: .movies)
                .id(ContentCategories.movies)
                .environmentObject(moviesContentScreenViewModel)

            ContentScreen(contentCategory: .series)
                .id(ContentCategories.series)
                .environmentObject(seriesContentScreenViewModel)
        }
        .mainHorizontalScroll($scrollPosition)
        .tabBarOverlay()
        .environmentObject(navigationVM)
        .environmentObject(contentVM)
    }
}
