//
//  ScrollView.swift
//  WDIW
//
//  Created by Nicolas von Trott on 22.05.24.
//

import SwiftUI

struct VerticalScrollView<Content: View>: View {
    internal init(
        _ scrollViewOffset: Binding<CGFloat>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content()
        self._scrollViewOffset = scrollViewOffset
    }
    
    @ViewBuilder var content: Content
    @Binding var scrollViewOffset: CGFloat
    
    var body: some View {
        ScrollView {
            content
                .background {
                    GeometryReader {
                        Color.clear.preference(
                            key: ScrollViewOffsetKey.self,
                            value: -$0.frame(in: .named("VerticalScrollView")).origin.y
                        )
                    }
                }
        }
        .onPreferenceChange(ScrollViewOffsetKey.self) {
            scrollViewOffset = $0
        }
        .coordinateSpace(name: "verticalScrollView")
    }
}

struct ScrollViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
