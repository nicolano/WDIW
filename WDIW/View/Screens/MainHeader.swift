//
//  AppHeader.swift
//  WDIW
//
//  Created by Nicolas von Trott on 29.06.24.
//

import SwiftUI

struct MainHeader: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentScreenViewModels: ContentScreenViewModels
    
    private var title: String {
        switch navigationVM.activeScreen {
        case .statistics:
            "Statistics"
        case .settings:
            "Settings"
        case .books:
            ContentCategories.books.getName()
        case .movies:
            ContentCategories.movies.getName()
        case .series:
            ContentCategories.series.getName()
        }
    }
    
    var body: some View {
        Group {
            Header(title: title) {
                switch navigationVM.activeScreen {
                case .statistics:
                    SettingsHeaderButtons
                case .settings:
                    SettingsHeaderButtons
                case .books:
                    ContentScreenHeaderButtons(contentCategory: .books)
                        .environmentObject(contentScreenViewModels.forBooks)
                case .movies:
                    ContentScreenHeaderButtons(contentCategory: .movies)
                        .environmentObject(contentScreenViewModels.forMovies)
                case .series:
                    ContentScreenHeaderButtons(contentCategory: .series)
                        .environmentObject(contentScreenViewModels.forSeries)
                }
            }
        }
        .background {
            if navigationVM.activeScreen == .statistics
                || navigationVM.activeScreen == .settings
                || navigationVM.contentScrollOffset > -115 {
                Rectangle().fill(Color.Custom.surface)
            }
        }
    }
}

extension MainHeader {
    private var SettingsHeaderButtons: some View {
        Button {
            navigationVM.navigateToContents()
        } label: {
            Text("Back").padding(.horizontal)
        }
    }
}
