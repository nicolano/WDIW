//
//  TabBarButton.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct TabBarButton: View {
    let contentCategory: ContentCategories
    let isActive: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack(spacing: 0) {
                Spacer(minLength: 0)
                
                Image(systemName: contentCategory.getIconName(isActive: isActive))
                    .padding(.trailing, .Spacing.s)
                
                Text(contentCategory.getName())

                Spacer(minLength: 0)
            }
            .font(.caption)
        }
        .buttonStyle(
            TabBarButtonstyle(
                isActive: isActive
            )
        )
    }
}

struct TabBarButtonstyle: ButtonStyle {
    let isActive: Bool

    func makeBody(configuration: Configuration) -> some View {
        if configuration.isPressed || isActive {
            configuration.label
                .padding()
                .background(
                    .ultraThickMaterial
                )
                .foregroundStyle(Color.Custom.primary)
                .clipShape(Capsule())
        } else {
            configuration.label
                .padding()
                .foregroundStyle(Color.Custom.primary)
                .clipShape(Capsule())
        }
    }
}
