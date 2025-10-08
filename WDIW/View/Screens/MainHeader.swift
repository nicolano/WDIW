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
    
    var contentCategory: ContentCategories {
        switch navigationVM.activeScreen {
        case .books:
            .books
        case .movies:
            .movies
        case .series:
            .series
        default:
            .books
        }
    }
    
    var contentScreenViewModel: ContentScreenViewModel {
        switch navigationVM.activeScreen {
        case .movies:
            contentScreenViewModels.forMovies
        case .series:
            contentScreenViewModels.forSeries
        default:
            contentScreenViewModels.forBooks
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
                default:
                    ContentScreenHeaderButtons(contentCategory: contentCategory)
                        .environmentObject(contentScreenViewModel)
                }
            }
        }
        .background {
            if navigationVM.activeScreen == .statistics
                || navigationVM.activeScreen == .settings
                || navigationVM.contentScrollOffset > -115 {
                Rectangle()
                    .fill(.clear)
                    .glassEffect(.clear, in: .rect(cornerRadii:
                                            RectangleCornerRadii(topLeading: 0,
                                                                 bottomLeading: .CornerRadius.dialog,
                                                                 bottomTrailing: .CornerRadius.dialog,
                                                                 topTrailing: 0)))
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
