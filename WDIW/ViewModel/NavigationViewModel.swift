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
    private var lastActiveContentScreen: Screens = .books
    @Published var selectedContent: MediaContent? = nil
    @Published var activeAddContentSheet: ContentCategories? = nil
    @Published var activeEditContentSheet: MediaContent? = nil
    @Published var showCSVInfoSheet: Bool = false
    @Published var contentScrollOffset: CGFloat = 0

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
        withAnimation(.spring) {
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
        withAnimation(.spring(.smooth, blendDuration: 0.1)) {
            selectedContent = nil
        }
    }
    
    func navigateToSettings() {
        withAnimation {
            lastActiveContentScreen = activeScreen
            activeScreen = .settings
        }
    }
    
    func navigateToContents() {
        withAnimation {
            activeScreen = lastActiveContentScreen
        }
    }
    
    func navigateFromOffset(offset: CGPoint) {
        if self.activeScreen == .settings {
            return 
        }
        
        if offset.x > .offsetNavToSettings {
            navigateToSettings()
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
