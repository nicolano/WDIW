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

    
    @State var activeCategory: ContentCategories = .books
    var offset: CGFloat = 0
    
    private func getTabBarButtonWidth(tabBarWidth: CGFloat) -> CGFloat {
        (tabBarWidth / 3) - (4 * .Spacing.xxs)
    }
    
    var body: some View {
        Group {
            GeometryReader { geo in
                VStack {
                    Spacer()
                    
                    NewButton(backgroundColor: settingsVM.preferredAccentColor) {
                        navigationVM.openAddContentSheet(contentCategory: activeCategory)
                    }
//                    .align(.trailing)
                    
                    HStack(spacing: 0) {
                        booksButton
                            .frame(
                                width: getTabBarButtonWidth(
                                    tabBarWidth: geo.size.width
                                )
                            )
                        
                        Spacer(minLength: 0)
                        
                        moviesButton
                            .frame(
                                width: getTabBarButtonWidth(
                                    tabBarWidth: geo.size.width
                                )
                            )

                        Spacer(minLength: 0)

                        seriesButton
                            .frame(
                                width: getTabBarButtonWidth(
                                    tabBarWidth: geo.size.width
                                )
                            )
                    }
                    .padding(.Spacing.xs)
                    .background(background)
                }
            }
        }
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
            .fill(Color.Custom.surface)
            .background {
                Color.gray.opacity(0.3)
            }
            .clipShape(Capsule())
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

#Preview {
    TabBar(activeCategory: .books, offset: 0)
        .padding(.horizontal, .Spacing.s)
        .environmentObject(NavigationViewModel())
}
