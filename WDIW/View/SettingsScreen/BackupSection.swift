//
//  BackupSection.swift
//  WDIW
//
//  Created by Nicolas von Trott on 09.05.24.
//

import SwiftUI

struct BackupSection: View {
    @EnvironmentObject private var contentVM: ContentViewModel

    private let backupManager = BackupManager()
    
    private func generateCSV() -> URL? {
        do {
            return try backupManager.generateCSVFileFromContents(
                contents: contentVM.mediaContents
            )
        } catch {
            return nil
        }
    }
    
    var body: some View {
        Section(
            header: Text("Import and Export Data"),
            footer: Text("")
        ) {
            ShareLink(
                item: generateCSV()!
            ) {
                Label(
                    "Export to CSV File",
                    systemImage: "list.bullet.rectangle.portrait"
                )
            }
            
            Button {
                
            } label: {
                Text("Import from CSV File")
            }
        }
        .headerProminence(.increased)
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
    BackupSection()
}
