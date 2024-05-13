//
//  ApplyColorScheme.swift
//  WDIW
//
//  Created by Nicolas von Trott on 13.05.24.
//

import SwiftUI

struct ApplyColorSchemeViewModifier: ViewModifier {
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    func body(content: Content) -> some View {
        Group {
            switch settingsVM.preferredTheme {
            case .dark:
                content.preferredColorScheme(.dark)
            case .light:
                content.preferredColorScheme(.light)
            case .system:
                content
            }
        }
    }
}

extension View {
    func applyColorScheme() -> some View {
        modifier(ApplyColorSchemeViewModifier())
    }
}
