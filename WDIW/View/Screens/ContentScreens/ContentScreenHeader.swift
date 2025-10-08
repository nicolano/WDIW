//
//  ContentScreenHeader.swift
//  WDIW
//
//  Created by Nicolas von Trott on 19.05.24.
//

import SwiftUI

struct ContentScreenHeaderButtons: View {
    @EnvironmentObject private var contentScreenVM: ContentScreenViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel

    let contentCategory: ContentCategories
    
    var body: some View {
        GlassEffectContainer(spacing: .Spacing.xs) {
            HStack.spacingXS {
                Button {
                    withAnimation {
                        contentScreenVM.toggleSearchField()
                    }
                } label: {
                    Image(systemName: contentScreenVM.showSearch ? "xmark" : "magnifyingglass")
                        .font(.title2)
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(.Spacing.s)
                        .transaction { $0.animation = nil }
                }
                .glassEffect(.regular.interactive())

                ContentScreenMenu(contentCategory: contentCategory)
            }
        }
    }
}
