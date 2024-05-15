//
//  StylingSection.swift
//  WDIW
//
//  Created by Nicolas von Trott on 13.05.24.
//

import SwiftUI

struct ThemeSection: View {
    @EnvironmentObject private var settingsVM: SettingsViewModel
        
    var body: some View {
        Section(
            header: Label("Theme", systemImage: "paintbrush.fill")
        ) {
            HStack {
                Text("Color Scheme")
                
                Spacer()
                
                Menu {
                    ForEach(ThemeOption.iterator, id: \.self) { option in
                        Button {
                            settingsVM.setTheme(option: option)
                        } label: {
                            Text(option.rawValue)
                        }
                    }
                } label: {
                    Text(settingsVM.preferredTheme.rawValue)
                }
            }
            
            ColorPicker("Accent Color", selection: $settingsVM.preferredAccentColor, supportsOpacity: false)
        }
        .headerProminence(.increased)
    }
}
