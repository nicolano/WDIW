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
    
    private var sharedModelContainer: SharedModelContainer
    
    init() {
        self.sharedModelContainer = SharedModelContainer(isInMemory: false)
        self.contentVM = ContentViewModel(
            modelContext: sharedModelContainer.modelContainer.mainContext
        )
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .sheets()
                .loadingDialog()
                .errorDialog()
                .infoDialog()
                .applyAccentColor()
                .applyColorScheme()
                .environmentObject(settingsVM)
                .environmentObject(navigationVM)
                .environmentObject(contentVM)
        }
        .modelContainer(sharedModelContainer.modelContainer)
    }
}
