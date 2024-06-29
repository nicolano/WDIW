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
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @EnvironmentObject private var contentScreenViewModels: ContentScreenViewModels
    
    let offset: CGFloat
    @State private var hideOpacity = 1.0
    
    private var title: String {
        switch navigationVM.activeScreen {
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
        .overlay {
            Image(systemName: "gear")
                .opacity(offset / .offsetNavToSettings)
                .scaleEffect(offset / .offsetNavToSettings)
                .font(.largeTitle)
                .opacity(hideOpacity)
                .foregroundStyle(settingsVM.preferredAccentColor)
                .offset(x: -40)
                .align(.bottomLeading)
                .padding(.BottomM)
        }
        .onChange(of: offset) { oldValue, newValue in
            if newValue > .offsetNavToSettings {
                hideOpacity = 0.0
            }
        }
        .onChange(of: navigationVM.activeScreen) { oldValue, newValue in
            if newValue == .books {
                hideOpacity = 1.0
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
