//
//  ContentScreenMenu.swift
//  WDIW
//
//  Created by Nicolas von Trott on 31.01.25.
//

import SwiftUI

struct ContentScreenMenu: View {
    @EnvironmentObject private var contentScreenVM: ContentScreenViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    let contentCategory: ContentCategories

    var body: some View {
        Menu {
            SortContentMenu(contentCategory: contentCategory)
            
            SelectYearContentMenu(contentCategory: contentCategory)
            
            Button {
                navigationVM.navigateToStatistics()
            } label: {
                Label("Statistics", systemImage: "chart.line.text.clipboard")
            }
            
            Button {
                navigationVM.navigateToSettings()
            } label: {
                Label("Settings", systemImage: "gear")
            }
        } label: {
            Image(systemName: "ellipsis.circle.fill")
                .font(.title2)
                .padding(.LeadingS)
                .contentShape(Rectangle())
        }
    }
}

