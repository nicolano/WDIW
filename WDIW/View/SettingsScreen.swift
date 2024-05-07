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

    private let backupManager = BackupManager()
    
    private func generateCSV() -> URL? {
//        do {
//            return try backupManager.generateCSVFileFromContents(
//                contents: contentVM.mediaContents
//            )
//        } catch {
//            return nil
//        }
        return nil
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Header(title: "Settings") {
                
            } primaryButton: {
                Button {
                    navigationVM.navigateToContents()
                } label: {
                    Text("Back").padding(.horizontal)
                }
            }
            
            List {
                Section("Backup") {
//                    ShareLink(
//                        item: generateCSV()!
//                    ) {
//                        Label(
//                            "Export to CSV",
//                            systemImage: "list.bullet.rectangle.portrait"
//                        )
//                    }
                    
                    
                    Button {
                        
                    } label: {
                        Text("Load from Backup")
                    }
                }
            }
            
            Spacer()
        }
        .overlay {
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    if backupManager.isLoading {
                        ProgressView()
                            .padding(.Spacing.l)
                            .background(Color.gray)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsScreen()
}
