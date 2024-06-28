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
    @EnvironmentObject private var contentScreenViewModels: ContentScreenViewModels

    @State private var isMovingToSettings: Bool = false
    
    @State private var scrollPosition: CGPoint = .zero

    var body: some View {
        ZStack {
            ZStack {
                if navigationVM.activeScreen == .books || navigationVM.activeScreen == .settings {
                    BooksScreen(offset: scrollPosition)
                        .id(ContentCategories.books)
                        .environmentObject(contentScreenViewModels.forBooks)
                        .mainHorizontalScroll($scrollPosition)
                        .transition(.identity)
                }
                
                if navigationVM.activeScreen == .movies {
                    ContentScreen(contentCategory: .movies)
                        .id(ContentCategories.movies)
                        .environmentObject(contentScreenViewModels.forMovies)
                        .transition(.identity)
                }
                
                if navigationVM.activeScreen == .series {
                    ContentScreen(contentCategory: .series)
                        .id(ContentCategories.series)
                        .environmentObject(contentScreenViewModels.forSeries)
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
