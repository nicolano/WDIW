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
    
    private var sharedModelContainer: SharedModelContainer
    
    init() {
        self.sharedModelContainer = SharedModelContainer(isInMemory: false)
        self.contentVM = ContentViewModel(
            modelContext: sharedModelContainer.modelContainer.mainContext
        )
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(navigationVM)
                .environmentObject(contentVM)
                .loadingDialog(navigationVM.showLoadingDialog)
        }
        .modelContainer(sharedModelContainer.modelContainer)
    }
}
