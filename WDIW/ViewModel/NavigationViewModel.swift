//
//  NavigationViewModel.swift
//  WDIW
//
//  Created by Nicolas von Trott on 21.02.24.
//

import Foundation
import SwiftUI
import Combine

class NavigationViewModel: ObservableObject {
    enum Screens {
        case settings, books, movies, series
    }
    
    @Published var activeScreen: Screens = .books    
    
    func navigateToSettings() {
        activeScreen = .settings
    }
    
    func navigateToContents() {
        activeScreen = .books
    }
    
    func navigateFromOffset(offset: CGPoint) {
        if offset == CGPoint(x: 100.0, y: 0.0) {
            navigateToSettings()
        } else if offset == .zero {
            navigateToContentCategory(category: .books)
        } else if offset == CGPoint(x: -UIScreen.main.bounds.width, y: 0.0) {
            navigateToContentCategory(category: .movies)
        } else if offset == CGPoint(x: -(2 * UIScreen.main.bounds.width), y: 0.0) {
            navigateToContentCategory(category: .series)
        }
    }
    
    func navigateToContentCategory(category: ContentCategories) {
        switch category {
        case .books:
            activeScreen = .books
        case .movies:
            activeScreen = .movies
        case .series:
            activeScreen = .series
        }
    }
}
