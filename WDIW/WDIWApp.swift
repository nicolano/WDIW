//
//  WDIWApp.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI
import SwiftData

@main
struct WDIWApp: App {
    @ObservedObject private var navigationVM: NavigationViewModel
    @ObservedObject private var contentVM: ContentViewModel
    @ObservedObject private var settingsVM: SettingsViewModel
    @ObservedObject private var contentScreenViewModels: ContentScreenViewModels
    
    private var sharedModelContainer: SharedModelContainer
    
    init() {
        // Initialize navigation and settings view models, and react to a possible change of
        // the displayed content categories
        let navigationVM = NavigationViewModel()
        let settingsVM = SettingsViewModel(onSelectedCategoriesChange: { categories in
            navigationVM.adjustNavigationToDisplayedCategories(
                categories,
                screenToAdjust: .lastActiveScreen
            )
        })
        navigationVM.adjustNavigationToDisplayedCategories(
            settingsVM.displayedCategories,
            screenToAdjust: .activeScreen
        )
        self.navigationVM = navigationVM
        self.settingsVM = settingsVM
        
        // Initialize database and content view model
        self.sharedModelContainer = SharedModelContainer(
            isInMemory: false,
            iCloudEnabled: settingsVM.iCloudEnabled
        )
        let contentVM = ContentViewModel(
            modelContext: sharedModelContainer.modelContainer.mainContext
        )
        self.contentScreenViewModels = ContentScreenViewModels(contentVM: contentVM)
        self.contentVM = contentVM
    }
    
    @Namespace var heroAnimation
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .ignoresSafeArea(.all, edges: .vertical)
                .sheets()
                .contentHero()
                .loadingDialog()
                .errorDialog()
                .infoDialog()
                .applyAccentColor()
                .applyColorScheme()
                .environmentObject(settingsVM)
                .environmentObject(contentVM)
                .environmentObject(contentScreenViewModels)
                .environmentObject(navigationVM)
                .addKeyboardVisibilityToEnvironment()
        }
        .modelContainer(sharedModelContainer.modelContainer)
    }
}
