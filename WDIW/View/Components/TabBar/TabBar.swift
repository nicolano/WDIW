//
//  TabBar.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel

    @Environment(\.keyboardShowing) var keyboardShowing
    @State var activeCategory: ContentCategories = .books
    
    var body: some View {
        HStack(spacing: 0) {
            NewButton(backgroundColor: settingsVM.preferredAccentColor) {
                navigationVM.openAddContentSheet(contentCategory: activeCategory)
            }
            .padding(.TrailingXS)
            .zIndex(1)
                                    
            GridRow {
                if settingsVM.displayedCategories.contains(.books) {
                    booksButton
                }
                
                if settingsVM.displayedCategories.contains(.movies) {
                    moviesButton
                }
                
                if settingsVM.displayedCategories.contains(.series) {
                    seriesButton
                }
            }
            .zIndex(0)
        }
        .padding(.Spacing.xs)
        .background(background)
        .opacity(keyboardShowing ? 0 : 1)
        .animation(.smooth, value: keyboardShowing)
        .ignoresSafeArea(.keyboard)
        .onReceive(navigationVM.$activeScreen) { value in
            switch value {
            case .books:
                activeCategory = .books
            case .movies:
                activeCategory = .movies
            case .series:
                activeCategory = .series
            default:
                ()
            }
        }
    }
}

extension TabBar {
    private var background: some View {
        Rectangle()
            .fill(.clear)
            .clipShape(Capsule())
            .glassEffect()
    }
    
    private var booksButton: some View {
        TabBarButton(
            contentCategory: .books,
            isActive: activeCategory == .books
        ) {
            withAnimation {
                navigationVM.navigateToContentCategory(
                    category: .books
                )
            }
        }
    }
    
    private var moviesButton: some View {
        TabBarButton(
            contentCategory: .movies,
            isActive: activeCategory == .movies
        ) {
            withAnimation {
                navigationVM.navigateToContentCategory(
                    category: .movies
                )
            }
        }
    }
    
    private var seriesButton: some View {
        TabBarButton(
            contentCategory: .series,
            isActive: activeCategory == .series
        ) {
            withAnimation {
                navigationVM.navigateToContentCategory(
                    category: .series
                )
            }
        }
    }
}
