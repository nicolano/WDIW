//
//  BooksScreen.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct BooksScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel

    var body: some View {
        ContentScreen(contentCategory: .books, content: []) {
            if contentVM.movies.isEmpty {
                NoContentSection(contentCategory: .books)
            } else {
                
            }
        }
        .environmentObject(navigationVM)
    }
}

#Preview {
    BooksScreen()
        .environmentObject(NavigationViewModel())
        .environmentObject(ContentViewModel())
}
