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
    @ObservedObject private var navigationVM = NavigationViewModel()
    @ObservedObject private var contentVM: ContentViewModel
    @ObservedObject private var settingsVM = SettingsViewModel()
    @ObservedObject private var contentScreenViewModels: ContentScreenViewModels
    
    private var sharedModelContainer: SharedModelContainer
    
    init() {
        self.sharedModelContainer = SharedModelContainer(isInMemory: false)
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
                .sheets()
                .contentHero()
                .loadingDialog()
                .errorDialog()
                .infoDialog()
                .applyAccentColor()
                .applyColorScheme()
                .environmentObject(settingsVM)
                .environmentObject(navigationVM)
                .environmentObject(contentVM)
                .environmentObject(contentScreenViewModels)
                .addKeyboardVisibilityToEnvironment()
        }
        .modelContainer(sharedModelContainer.modelContainer)
    }
}
