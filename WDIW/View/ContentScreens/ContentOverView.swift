//
//  ContentView.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct ContentOverView: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel

    @State private var scrollPosition: CGPoint = .zero
    
    var body: some View {
        HStack.zeroSpacing {
            BooksScreen(offset: scrollPosition)
                .id(ContentCategories.books)
            
            ContentScreen(contentCategory: .movies)
                .id(ContentCategories.movies)
            
            ContentScreen(contentCategory: .series)
                .id(ContentCategories.series)
        }
        .mainHorizontalScroll($scrollPosition)
        .tabBarOverlay()
        .addContentSheet()
        .editContentSheet()
        .environmentObject(navigationVM)
        .environmentObject(contentVM)
    }
}

#Preview {
    ContentOverView()
        .environmentObject(NavigationViewModel())
}
