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
    init(onSelectedCategoriesChange: @escaping (_ categories: [ContentCategories]) -> Void) {
        self.onSelectedCategoriesChange = onSelectedCategoriesChange
    }
    
    let onSelectedCategoriesChange: ([ContentCategories]) -> Void
    
    @AppStorage("preferredTheme") var preferredTheme: ThemeOption = .system
    @AppStorage("accentColor") var preferredAccentColor: Color = .blue
    @AppStorage("displayedCategories") var displayedCategories: [ContentCategories] = ContentCategories.iterator
    @AppStorage("iCloudEnabled") var iCloudEnabled: Bool = true
    
    func toggleICloudEnabled() {
        iCloudEnabled.toggle()
    }
    
    func setDisplayedCategories(contentCategory: ContentCategories) {
        if displayedCategories.contains(contentCategory) {
            if displayedCategories.count == 1 {
                return
            }
            
            displayedCategories.removeAll { it in
                it == contentCategory
            }
        } else {
            displayedCategories.append(contentCategory)
        }
        
        onSelectedCategoriesChange(displayedCategories)
    }
    
    func selectedCategoriesToDisplayString() -> String {
        var selectedCategories = ""
        for category in displayedCategories {
            if !selectedCategories.isEmpty {
                selectedCategories += ", "
            }
            selectedCategories += category.getName()
        }
        
        return selectedCategories.isEmpty ? "None" : selectedCategories
    }
    
    func setTheme(option: ThemeOption) {
        preferredTheme = option
    }
    
    func setAccessColor(color: Color) {
        preferredAccentColor = color
    }
}
