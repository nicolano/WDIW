//
//  ContentScreen.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct ContentScreen: View {
    let contentCategory: ContentCategories
    let content: [Content]
    let onAddItemTap: (ContentCategories) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            headerSection
                .padding(.top, .Spacing.l)
            
            Spacer()
        }
        .padding(.horizontal, .Spacing.l)
    }
}

extension ContentScreen {
    private var headerSection: some View {
        HStack {
            Text(contentCategory.getName())
                .font(.largeTitle)
                .fontWeight(.black)
            
            Spacer()
            
            Button {
                onAddItemTap(contentCategory)
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(Color.Custom.onPrimary)
                    .bold()
                    .padding(.Spacing.s)
                    .background(Color.Custom.primary)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    ContentScreen(
        contentCategory: ContentCategories.books,
        content: []
    ) { _ in }
}
