//
//  MainView.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.02.24.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentScreenViewModels: ContentScreenViewModels
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @EnvironmentObject private var statisticsVM: StatisticsViewModel

    var body: some View {
        ZStack {
            ZStack {
                if navigationVM.activeScreen == .books || navigationVM.activeScreen == .settings {
                    ContentScreen(contentCategory: .books)
                        .id(ContentCategories.books)
                        .environmentObject(contentScreenViewModels.forBooks)
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
            
            if navigationVM.activeScreen == .settings {
                SettingsScreen()
                    .transition(.move(edge: .leading))
                    .zIndex(100)
            }
            
            if navigationVM.activeScreen == .statistics {
                StatisticsScreen()
                    .transition(.move(edge: .leading))
                    .zIndex(100)
            }
        }
        .safeAreaInset(edge: .top) { MainHeader() }
        .tabBarOverlay()
    }
}
