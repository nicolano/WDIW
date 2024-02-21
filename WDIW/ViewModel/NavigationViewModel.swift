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
        case books, movies, series
    }
    
    @Published var activeScreen: Screens = .books    
    
    func navigateFromOffset(offset: CGPoint) {
        if offset == .zero {
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
