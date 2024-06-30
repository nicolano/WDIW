//
//  SwipeToSettingsModifier.swift
//  WDIW
//
//  Created by Nicolas von Trott on 30.06.24.
//

import SwiftUI

struct SwipeToSettingsModifier: ViewModifier {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel

    @State private var isMovingToSettings: Bool = false
    @State private var scrollPosition: CGFloat = .zero
    @State private var hideOpacity = 1.0
    
    func body(content: Content) -> some View {
        content
            .overlay { gearOverlay }
            .mainHorizontalScroll($scrollPosition)
            .onChange(of: scrollPosition) { oldValue, newValue in
                if newValue > .offsetNavToSettings {
                    hideOpacity = 0.0
                }
            }
            .onChange(of: navigationVM.activeScreen) { oldValue, newValue in
                if newValue == .books {
                    hideOpacity = 1.0
                }
            }
            // Sensory Feedback when moving to settings screen
            .sensoryFeedback(.success, trigger: isMovingToSettings)
            .onChange(of: navigationVM.activeScreen, { oldValue, newValue in
                if oldValue == .books && newValue == .settings {
                    isMovingToSettings.toggle()
                }
            })
    }
}

extension SwipeToSettingsModifier {
    private var gearOverlay: some View {
        Group {
            let multiplier = scrollPosition / .offsetNavToSettings
            Image(systemName: "gear")
                .opacity(multiplier)
                .opacity(hideOpacity)
                .scaleEffect(multiplier)
                .font(.largeTitle)
                .foregroundStyle(settingsVM.preferredAccentColor)
                .align(.vCenter)
                .align(.leading)
                .offset(x: -50)
        }
    }
}

extension View {
    func swipeToSettings() -> some View {
        modifier(SwipeToSettingsModifier())
    }
}
