//
//  MainScrollViewModifier.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct MainHorizontalScrollViewModifier: ViewModifier {
    @EnvironmentObject private var navigationVM: NavigationViewModel

    @Binding var scrollPosition: CGPoint
    
    func body(content: Content) -> some View {
        ScrollViewReader { scrollViewReader in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    content
                }
                .scrollTargetLayout()
                .background(GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geometry.frame(in: .named("scroll")).origin
                        )
                })
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    scrollPosition = value
                    navigationVM.navigateFromOffset(offset: value)
                }
            }
            .coordinateSpace(name: "scroll")
            .scrollTargetBehavior(.paging)
            .onReceive(navigationVM.$activeScreen) { value in
                switch value {
                case .books:
                    withAnimation {
                        scrollViewReader.scrollTo(ContentCategories.books)
                    }
                case .movies:
                    withAnimation {
                        scrollViewReader.scrollTo(ContentCategories.movies)
                    }
                case .series:
                    withAnimation {
                        scrollViewReader.scrollTo(ContentCategories.series)
                    }
                default:
                    ()
                }
            }
            
            Spacer()
        }
    }
}

extension View {
    func mainHorizontalScroll(_ scrollPosition: Binding<CGPoint>) -> some View {
        modifier(MainHorizontalScrollViewModifier(scrollPosition: scrollPosition))
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}
