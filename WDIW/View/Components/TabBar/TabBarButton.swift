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
                Image(
                    systemName: contentCategory.getIconName(
                        isActive: isActive
                    )
                )
                .padding(.trailing, .Spacing.s)
                
                Text(contentCategory.getName())
            }
        }
        .buttonStyle(TabBarButtonstyle())
    }
}

struct TabBarButtonstyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        if configuration.isPressed {
            configuration.label
                .padding()
                .background(.thinMaterial)
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

#Preview {
    TabBarButton(contentCategory: .books, isActive: true) {
        
    }
    .padding(100)
    .background(Color.green)
}
