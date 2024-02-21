//
//  TabBar.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
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
                    
                    HStack(spacing: 0) {
                        TabBarButton(
                            contentCategory: .books,
                            isActive: activeCategory == .books
                        ) {
                            navigationVM.navigateToContentCategory(category: .books)
                        }
                        .frame(width: getTabBarButtonWidth(tabBarWidth: geo.size.width))
                        
                        Spacer(minLength: 0)
                        
                        TabBarButton(
                            contentCategory: .movies,
                            isActive: activeCategory == .movies
                        ) {
                            navigationVM.navigateToContentCategory(category: .movies)
                        }
                        .frame(width: getTabBarButtonWidth(tabBarWidth: geo.size.width))

                        Spacer(minLength: 0)

                        TabBarButton(
                            contentCategory: .series,
                            isActive: activeCategory == .series
                        ) {
                            navigationVM.navigateToContentCategory(category: .series)
                        }
                        .frame(width: getTabBarButtonWidth(tabBarWidth: geo.size.width))
                    }
                    .padding(.Spacing.xs)
                    .background {
                        Rectangle()
                            .fill(Color.Custom.surface)
                            .background {
                                Color.gray.opacity(0.3)
                            }
                            .clipShape(Capsule())
                    }
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

#Preview {
    TabBar(activeCategory: .books, offset: 0)
        .padding(.horizontal, .Spacing.s)
        .environmentObject(NavigationViewModel())
}
