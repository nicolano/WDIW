//
//  NavigationViewModel.swift
//  WDIW
//
//  Created by Nicolas von Trott on 21.02.24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class NavigationViewModel: ObservableObject {
    enum Screens {
        case settings, books, movies, series
    }
    
    enum Sheets {
        case csvInfo
    }
    
    @Published var activeScreen: Screens = .books
    @Published var selectedContent: MediaContent? = nil
    @Published var activeAddContentSheet: ContentCategories? = nil
    @Published var activeEditContentSheet: MediaContent? = nil
    @Published var showCSVInfoSheet: Bool = false
    
    func openSheet(type: Sheets) {
        switch type {
        case .csvInfo:
            showCSVInfoSheet = true
        }
    }
    
    func closeSheet(type: Sheets) {
        switch type {
        case .csvInfo:
            showCSVInfoSheet = false
        }
    }
    
    func openAddContentSheet(contentCategory: ContentCategories) {
        activeAddContentSheet = contentCategory
    }
    
    func openEditContentSheet(content: MediaContent) {
        activeEditContentSheet = content
    }
    
    func openSelectedContentHero(content: MediaContent) {
        withAnimation {
            selectedContent = content
        }
    }
    
    func closeAddContentSheet() {
        activeAddContentSheet = nil
    }
    
    func closeEditContentSheet() {
        activeEditContentSheet = nil
    }
    
    func closeSelectedContentHero() {
        withAnimation {
            selectedContent = nil
        }
    }
    
    func navigateToSettings() {
        activeScreen = .settings
    }
    
    func navigateToContents() {
        activeScreen = .books
    }
    
    func navigateFromOffset(offset: CGPoint) {
        if self.activeScreen == .settings {
            return 
        }
        
        if offset.x > .offsetNavToSettings {
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
