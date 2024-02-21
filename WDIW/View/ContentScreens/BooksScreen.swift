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

    let offset: CGPoint
    
    @State private var hideOpacity = 1.0
    
    var body: some View {
        ContentScreen(contentCategory: .books, content: []) {
            if contentVM.movies.isEmpty {
                NoContentSection(contentCategory: .books)
            } else {
                
            }
        }
        .overlay {
            VStack {
                HStack {
                    Image(systemName: "gear")
                        .opacity(offset.x / .offsetNavToSettings)
                        .scaleEffect(offset.x / .offsetNavToSettings)
                        .font(.largeTitle)
                        .opacity(hideOpacity)
                    
                    Spacer()
                }
                .padding(.top, 12)
                .foregroundStyle(Color.Custom.primary)
                
                Spacer()
            }
            .offset(x: -40)
        }
        .environmentObject(navigationVM)
        .onChange(of: offset) { oldValue, newValue in
            if newValue.x > .offsetNavToSettings {
                hideOpacity = 0.0
            }
        }
        .onChange(of: navigationVM.activeScreen) { oldValue, newValue in
            if newValue == .books {
                hideOpacity = 1.0
            }
        }
    }
}

#Preview {
    BooksScreen(offset: CGPoint(x: 0, y: 0))
        .environmentObject(NavigationViewModel())
        .environmentObject(
            ContentViewModel(
                modelContext: SharedModelContainer(
                    isInMemory: true
                ).modelContainer.mainContext
            )
        )}
