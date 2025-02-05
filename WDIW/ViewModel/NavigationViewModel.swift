//
//  NavigationViewModel.swift
//  WDIW
//
//  Created by Nicolas von Trott on 21.02.24.
//

import Foundation
import SwiftUI
import Combine

enum Screens {
    case statistics, settings, books, movies, series
}

extension Screens {
    func getRelatedContentCategory() -> ContentCategories {
        switch self {
        case .statistics:
            return .books
        case .settings:
            return .books
        case .books:
            return .books
        case .movies:
            return .movies
        case .series:
            return .series
        }
    }
}

@MainActor
class NavigationViewModel: ObservableObject {
    enum Sheets {
        case csvInfo
    }
    
    @Published var activeScreen: Screens = .books
    private var lastActiveContentScreen: Screens = .books
    @Published var selectedContent: ContentEntry? = nil
    @Published var activeAddContentSheet: ContentCategories? = nil
    @Published var activeEditContentSheet: ContentEntry? = nil
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
    
    func openEditContentSheet(content: ContentEntry) {
        activeEditContentSheet = content
    }
    
    func openSelectedContentHero(content: ContentEntry) {
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
    
    func navigateToStatistics() {
        withAnimation {
            lastActiveContentScreen = activeScreen
            activeScreen = .statistics
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
    
    
    enum NavigationAdjustmentOptions { case activeScreen, lastActiveScreen }
    func adjustNavigationToDisplayedCategories(
        _ displayedcategories: [ContentCategories],
        screenToAdjust: NavigationAdjustmentOptions
    ) {
        if displayedcategories.contains(activeScreen.getRelatedContentCategory()) {
            return
        } else {
            switch screenToAdjust {
            case .activeScreen:
                switch displayedcategories.first ?? .books {
                case .books:
                    activeScreen = .books
                case .movies:
                    activeScreen = .movies
                case .series:
                    activeScreen = .series
                }
            case .lastActiveScreen:
                switch displayedcategories.first ?? .books {
                case .books:
                    lastActiveContentScreen = .books
                case .movies:
                    lastActiveContentScreen = .movies
                case .series:
                    lastActiveContentScreen = .series
                }
            }
        }
    }
}
