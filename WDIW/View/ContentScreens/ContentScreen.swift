//
//  ContentScreen.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct ContentScreen<Content: View>: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    let contentCategory: ContentCategories
    let content: [MediaContent]
    @ViewBuilder let contentView: Content
    
    var body: some View {
        VStack.zeroSpacing(alignment: .leading) {
            headerSection
            
            contentView
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

extension ContentScreen {
    private var headerSection: some View {
        Header(title: contentCategory.getName()) {
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.Custom.primary)
                    .bold()
                    .padding(.Spacing.s)
                    .clipShape(Circle())
            }
        } primaryButton: {
            Button {
                navigationVM.openAddContentSheet(
                    contentCategory: contentCategory
                )
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(Color.Custom.onPrimary)
                    .padding(.Spacing.s)
                    .background(Color.Custom.primary)
                    .clipShape(Circle())
            }
        }
    }
}
