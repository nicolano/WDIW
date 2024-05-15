//
//  SettingsScreen.swift
//  WDIW
//
//  Created by Nicolas von Trott on 21.02.24.
//

import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel

    var body: some View {
        VStack(spacing: 0) {
            Header(title: "Settings") {
                
            } secondaryButton: {
                
            } primaryButton: {
                Button {
                    navigationVM.navigateToContents()
                } label: {
                    Text("Back").padding(.horizontal)
                }
            }
            .padding(.BottomS)
            
            List {
                BackupSection()     
                ResetSection()
                ThemeSection()
            }
            .listStyle(.sidebar)

            Spacer()
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    SettingsScreen()
}
