//
//  MainView.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.02.24.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel

    @State private var isMovingToSettings: Bool = false
    
    var body: some View {
        ZStack {
            switch navigationVM.activeScreen {
            case .settings:
                SettingsScreen()
                    .transition(.move(edge: .leading))
            default:
                ContentOverView()
                    .transition(.move(edge: .trailing))
                    .zIndex(10)
            }
        }
        // Sensory Feedback when moving to settings screen
        .sensoryFeedback(.success, trigger: isMovingToSettings)
        .onChange(of: navigationVM.activeScreen, { oldValue, newValue in
            if oldValue == .books && newValue == .settings {
                isMovingToSettings.toggle()
            }
        })
        .animation(.default, value: self.navigationVM.activeScreen)
        .background {
            VStack {
                Rectangle()
                    .fill(Color.Custom.surface)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 70)
                
                Spacer()
            }
        }
    }
}
