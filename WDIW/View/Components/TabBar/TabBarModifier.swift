//
//  TabBarModifier.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI
import Glur

struct TabBarModifier: ViewModifier {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    
    
    func body(content: Content) -> some View {
        content
            .overlay {
                VStack {
                    Spacer()
                    
                    TabBar()
                        .padding(.horizontal, .Spacing.m)
                        .padding(.bottom, safeAreaInsets.bottom)
                        .background {
                            Rectangle()
                                .fill(
                                    Material.ultraThinMaterial
                                )
                                .padding(.TopL)
                        }
                }
            }
    }
}

extension View {
    func tabBarOverlay() -> some View {
        modifier(TabBarModifier())
    }
}
private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
