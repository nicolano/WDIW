//
//  ContentView.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel

    @State private var scrollPosition: CGPoint = .zero

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { scrollViewReader in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        BooksScreen()
                            .id(ContentCategories.books)
                            .environmentObject(contentVM)
                        
                        MoviesScreen()
                            .id(ContentCategories.movies)
                            .environmentObject(contentVM)
                        
                        SeriesScreen()
                            .id(ContentCategories.series)
                            .environmentObject(contentVM)
                        
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
                        self.scrollPosition = value
                        print(value)
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
        .overlay(tabBar)
        .sheet(
            isPresented: Binding(get: {
                navigationVM.activeAddContentSheet != nil
            }, set: { isOpen in
                if !isOpen {
                    navigationVM.closeAddContentSheet()
                }
            })
        ) {
            if let category = navigationVM.activeAddContentSheet {
                AddContentSheet(contentCategory: category)
            }
            
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

extension ContentView {
    private var tabBar: some View {
        VStack {
            Spacer()
            
            TabBar()
                .environmentObject(navigationVM)
                .padding(.horizontal, .Spacing.m)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationViewModel())
}
