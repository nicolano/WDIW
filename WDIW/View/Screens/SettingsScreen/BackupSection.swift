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
    @State private var exportUrl: URLWrapper? = nil
    
    var body: some View {
        Section(
            header: Text("Import and Export Data"),
            footer: footer
        ) {
            Button {
//                backupManager.testIsLoading()
            } label: {
                Label(
                    "Import from CSV File",
                    systemImage: "square.and.arrow.down"
                )
            }
            
            Button {
                Task {
                    if let url = await backupManager.generateCSVFileFromContents(
                        contents: contentVM.mediaContents
                    ) {
                        exportUrl = URLWrapper(id: UUID(), url: url)
                    }
                }
            } label: {
                Label(
                    "Export as CSV File",
                    systemImage: "list.bullet.rectangle.portrait"
                )
            }
            .preference(key: LoadingPreferenceKey.self, value: backupManager.isLoading)
            .preference(key: ErrorPreferenceKey.self, value: backupManager.errorMessage)
        }
        .headerProminence(.increased)
        .sheet(item: $exportUrl, onDismiss: {
            
        }, content: { exportUrl in
            ActivityViewController(exportUrl: exportUrl)
        })
    }
}

struct URLWrapper: Identifiable {
    var id: UUID
    let url: URL
}

struct ActivityViewController: UIViewControllerRepresentable {
    let exportUrl: URLWrapper
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: [exportUrl.url], applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}

extension BackupSection {
    private var footer: some View {
        HStack {
            Button {
                navigationVM.openSheet(type: .csvInfo)
            } label: {
                Group {
                    Text("You can import and export data from and to a CSV file. For more information about CSV files, click here. ")
                    +
                    Text(Image(systemName: "info.circle"))
                }
                .multilineTextAlignment(.leading)
                .foregroundColor(.secondary)
                .font(.caption)
            }
        }
    }
}
