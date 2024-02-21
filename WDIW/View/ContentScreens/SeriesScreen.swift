//
//  Series.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct SeriesScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel

    var body: some View {
        ContentScreen(contentCategory: .series, content: []) {
            if contentVM.series.isEmpty {
                NoContentSection(contentCategory: .series)
            } else {
                
            }
        }
        .environmentObject(navigationVM)
    }
}

#Preview {
    SeriesScreen()
        .environmentObject(NavigationViewModel())
        .environmentObject(
            ContentViewModel(
                modelContext: SharedModelContainer(
                    isInMemory: true
                ).modelContainer.mainContext
            )
        )
}
