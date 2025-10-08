//
//  PersonalizationSection.swift
//  WDIW
//
//  Created by Nicolas von Trott on 30.06.24.
//

import SwiftUI

struct PersonalizationSection: View {
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    var body: some View {
        Section(
            header: Label("Personalization", systemImage: "person.fill")
        ) {
            HStack {
                Text("Categories")
                
                Spacer()
                
                Menu {
                    ForEach(ContentCategories.iterator, id: \.self) { option in
                        Button {
                            settingsVM.setDisplayedCategories(contentCategory: option)
                        } label: {
                            Label(
                                option.getName(),
                                systemImage: settingsVM.displayedCategories.contains(option) ? "checkmark" : ""
                            )
                        }
                    }
                } label: {
                    Text(settingsVM.selectedCategoriesToDisplayString())
                }
            }
            .padding(.BottomS)
        }
        .headerProminence(.increased)
    }
}

#Preview {
    PersonalizationSection()
}
