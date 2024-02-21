//
//  SettingsScreen.swift
//  WDIW
//
//  Created by Nicolas von Trott on 21.02.24.
//

import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    var body: some View {
        VStack(spacing: 0) {
            Header(title: "Settings") {
                
            } primaryButton: {
                Button {
                    navigationVM.navigateToContents()
                } label: {
                    Text("Back")
                        .bold()
                }
            }
            
            List {
                Section("Backup") {
                    Button {
                    
                    } label: {
                        Text("Create Backup")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Load from Backup")
                    }
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    SettingsScreen()
}
