//
//  BackupSection.swift
//  WDIW
//
//  Created by Nicolas von Trott on 09.05.24.
//

import SwiftUI

struct BackupSection: View {
    @EnvironmentObject private var contentVM: ContentViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    @StateObject private var backupManager = BackupManager()
    @State private var isShare = false

    @State private var exportUrl: URL? = nil
    
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
            Button {
                backupManager.testIsLoading()
            } label: {
                Label(
                    "Import from CSV File",
                    systemImage: "square.and.arrow.down"
                )
            }
            
            if let exportUrl = exportUrl {
                ShareLink(
                    item: exportUrl
                ) {
                    Label(
                        "Export to CSV File",
                        systemImage: "list.bullet.rectangle.portrait"
                    )
                }
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: {
            exportUrl = generateCSV()
        })
        .headerProminence(.increased)
        .onReceive(backupManager.$isLoading, perform: { _ in
            navigationVM.triggerLoadingDialog(isLoading: backupManager.isLoading)
        })
    }
}
