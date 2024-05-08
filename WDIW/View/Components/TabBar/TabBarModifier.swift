//
//  TabBarModifier.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct TabBarModifier: ViewModifier {
    @EnvironmentObject private var navigationVM: NavigationViewModel

    func body(content: Content) -> some View {
        content
            .overlay {
                VStack {
                    Spacer()
                    
                    TabBar()
                        .environmentObject(navigationVM)
                        .padding(.horizontal, .Spacing.m)
                }
            }
    }
}

extension View {
    func tabBarOverlay() -> some View {
        modifier(TabBarModifier())
    }
}
