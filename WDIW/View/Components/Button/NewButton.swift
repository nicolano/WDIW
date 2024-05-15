//
//  NewButton.swift
//  WDIW
//
//  Created by Nicolas von Trott on 15.05.24.
//

import SwiftUI

struct NewButton: View {
    let backgroundColor: Color
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Image(systemName: "plus")
                .bold()
                .font(.title)
                .foregroundStyle(Color.Custom.onPrimary)
                .padding(.Spacing.s)
        }
        .buttonStyle(NewButtonStyle(backgroundColor: backgroundColor))
    }
}

struct NewButtonStyle: ButtonStyle {
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background {
//                RoundedRectangle(cornerRadius: .CornerRadius.contentItem)
                Circle()
                    .fill(backgroundColor)
                    .shadow(radius: 3)
            }
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.smooth, value: configuration.isPressed)
    }
}
