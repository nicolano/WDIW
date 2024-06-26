//
//  TabBarButton.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct TabBarButton: View {
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    let contentCategory: ContentCategories
    let isActive: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            VStack(spacing: 0) {    
                Image(systemName: contentCategory.getIconName(isActive: isActive))
                Text(contentCategory.getName())
            }
            .font(.caption)
            .align(.hCenter)
        }
        .buttonStyle(
            TabBarButtonstyle(
                isActive: isActive,
                foregroundColor: settingsVM.preferredAccentColor
            )
        )
    }
}

struct TabBarButtonstyle: ButtonStyle {
    let isActive: Bool
    let foregroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        if configuration.isPressed || isActive {
            configuration.label
                .padding(.horizontal)                
                .padding(.vertical, .Spacing.s)
                .background(.ultraThickMaterial)
                .foregroundStyle(foregroundColor)
                .clipShape(Capsule())
        } else {
            configuration.label
                .padding(.horizontal)
                .padding(.vertical, .Spacing.s)
                .foregroundStyle(foregroundColor)
                .clipShape(Capsule())
        }
    }
}
