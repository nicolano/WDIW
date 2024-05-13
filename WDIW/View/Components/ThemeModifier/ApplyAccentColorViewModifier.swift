//
//  ApplyAccentColorViewModifier.swift
//  WDIW
//
//  Created by Nicolas von Trott on 13.05.24.
//

import SwiftUI

struct ApplyAccentColorViewModifier: ViewModifier {
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    func body(content: Content) -> some View {
        content.tint(settingsVM.preferredAccentColor)
    }
}

extension View {
    func applyAccentColor() -> some View {
        modifier(ApplyAccentColorViewModifier())
    }
}
