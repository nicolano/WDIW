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
        HStack.spacingM {
            Button {
                withAnimation {
                    contentScreenVM.toggleSearchField()
                }
            } label: {
                Image(systemName: contentScreenVM.showSearch ? "x.circle.fill" : "magnifyingglass")
                    .bold()
                    .font(.title2)
            }
            
            ContentScreenMenu(contentCategory: contentCategory)
        }
    }
}
