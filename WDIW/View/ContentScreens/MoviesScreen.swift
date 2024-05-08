//
//  MoviesScreen.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct MoviesScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel
    
    var body: some View {
        ContentScreen(contentCategory: .movies, content: []) {
            if contentVM.movies.isEmpty {
                NoContentSection(contentCategory: .movies)
            } else {
                ScrollView {
                    ForEach(contentVM.movies, id: \.self) { movies in
                        ContentItem(movies) {
                            contentVM.contentToEdit = movies
                        }
                        .padding(.HorizontalM)
                        .padding(.TopM)
                    }
                }
            }
        }
        .environmentObject(navigationVM)
    }
}

#Preview {
    MoviesScreen()
        .environmentObject(NavigationViewModel())
        .environmentObject(
            ContentViewModel(
                modelContext: SharedModelContainer(
                    isInMemory: true
                ).modelContainer.mainContext
            )
        )
}
