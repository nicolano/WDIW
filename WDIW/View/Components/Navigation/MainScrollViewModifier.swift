//
//  MainScrollViewModifier.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct MainHorizontalScrollViewModifier: ViewModifier {
    @EnvironmentObject private var navigationVM: NavigationViewModel

    @Binding var scrollPosition: CGFloat
    
    func body(content: Content) -> some View {
        VStack {
            content
        }
        .background(GeometryReader { geometry in
            Color.clear
                .preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: geometry.frame(in: .named("scroll")).origin
                )
        })
        .offset(x: scrollPosition)
        .highPriorityGesture(DragGesture()
            .onChanged({ value in
                if value.startLocation.x > CGFloat(50.0){
                    return
                }
                
                if navigationVM.activeScreen == .settings {
                    withAnimation(.smooth) {
                        scrollPosition = 0
                    }
                    return
                }
                
                if value.translation.width > 0 && value.translation.width < 120 {
                    scrollPosition = value.translation.width
                }
            })
            .onEnded({ value in
                withAnimation(.smooth) {
                    scrollPosition = 0
                }
            })
        )
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            scrollPosition = value.x
            navigationVM.navigateFromOffset(offset: value)
        }
        .coordinateSpace(name: "scroll")

    }
}

extension View {
    func mainHorizontalScroll(_ scrollPosition: Binding<CGFloat>) -> some View {
        modifier(MainHorizontalScrollViewModifier(scrollPosition: scrollPosition))
    }
}
