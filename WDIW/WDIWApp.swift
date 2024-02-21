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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Book.self, Movie.self, Series.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @ObservedObject private var navigationVM = NavigationViewModel()
    @ObservedObject private var contentVM = ContentViewModel()

    var body: some Scene {
        WindowGroup {
            ZStack {
                switch navigationVM.activeScreen {
                case .settings:
                    SettingsScreen()
                        .environmentObject(navigationVM)
                        .transition(.move(edge: .leading))
                default:
                    ContentView()
                        .environmentObject(navigationVM)
                        .environmentObject(contentVM)
                        .transition(.move(edge: .trailing))
                        .zIndex(10)
                }
            }
            .animation(.default, value: self.navigationVM.activeScreen)
            .background {
                VStack {
                    Rectangle().fill(Color.Custom.surface).ignoresSafeArea(edges: .top)
                        .frame(height: 95)
                    
                    Spacer()
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
