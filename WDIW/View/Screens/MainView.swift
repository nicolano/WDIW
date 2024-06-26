//
//  MainView.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.02.24.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel
    
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

    @ObservedObject private var bookContentScreenViewModel: ContentScreenViewModel
    @ObservedObject private var moviesContentScreenViewModel: ContentScreenViewModel
    @ObservedObject private var seriesContentScreenViewModel: ContentScreenViewModel
    
    @State private var isMovingToSettings: Bool = false
    
    @State private var scrollPosition: CGPoint = .zero

    var body: some View {
        ZStack {
            ZStack {
                if navigationVM.activeScreen == .books || navigationVM.activeScreen == .settings {
                    BooksScreen(offset: scrollPosition)
                        .id(ContentCategories.books)
                        .environmentObject(bookContentScreenViewModel)
                        .mainHorizontalScroll($scrollPosition)
                        .transition(.identity)
                }
                
                if navigationVM.activeScreen == .movies {
                    ContentScreen(contentCategory: .movies)
                        .id(ContentCategories.movies)
                        .environmentObject(moviesContentScreenViewModel)
                        .transition(.identity)
                }
                
                if navigationVM.activeScreen == .series {
                    ContentScreen(contentCategory: .series)
                        .id(ContentCategories.series)
                        .environmentObject(seriesContentScreenViewModel)
                        .transition(.identity)
                }
            }
            .tabBarOverlay()
            
            if navigationVM.activeScreen == .settings {
                SettingsScreen()
                    .transition(.move(edge: .leading))
                    .zIndex(100)
            }
        }
        // Sensory Feedback when moving to settings screen
        .sensoryFeedback(.success, trigger: isMovingToSettings)
        .onChange(of: navigationVM.activeScreen, { oldValue, newValue in
            if oldValue == .books && newValue == .settings {
                isMovingToSettings.toggle()
            }
        })
        .animation(.default, value: self.navigationVM.activeScreen)
        .background {
            VStack {
                Rectangle()
                    .fill(Color.Custom.surface)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 70)
                
                Spacer()
            }
        }
    }
}
