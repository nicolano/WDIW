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
                .padding(.horizontal, .Spacing.l)
                .padding(.top, .Spacing.l)
                .padding(.bottom, .Spacing.m)
                .background {
                    Rectangle()
                        .fill(Color.Custom.surface)
                        .ignoresSafeArea()
                }
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
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
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.Custom.primary)
                    .bold()
                    .padding(.Spacing.s)
                    .clipShape(Circle())
            }
            
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
