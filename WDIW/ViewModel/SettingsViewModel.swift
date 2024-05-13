//
//  SettingsViewModel.swift
//  WDIW
//
//  Created by Nicolas von Trott on 13.05.24.
//

import Foundation
import SwiftUI
import Combine

enum ThemeOption: String {
    case dark = "Dark"
    case light = "Light"
    case system = "System"
}

extension ThemeOption {
    static var iterator: [ThemeOption] = [.system, .light, .dark]
}

@MainActor
class SettingsViewModel: ObservableObject {
    @AppStorage("preferredTheme") var preferredTheme: ThemeOption = .system
    @AppStorage("accentColor") var preferredAccentColor: Color = .blue
    
    func setTheme(option: ThemeOption) {
        preferredTheme = option
    }
    
    func setAccessColor(color: Color) {
        preferredAccentColor = color
    }
}
