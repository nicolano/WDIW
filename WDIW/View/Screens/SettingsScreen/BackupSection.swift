//
//  BackupSection.swift
//  WDIW
//
//  Created by Nicolas von Trott on 09.05.24.
//

import SwiftUI

struct URLWrapper: Identifiable {
    var id: UUID
    let url: URL
}

struct BackupSection: View {
    @EnvironmentObject private var contentVM: ContentViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    @StateObject private var backupManager = BackupManager()
    @State private var exportUrl: URLWrapper? = nil
    @State private var fileImporterIsOpen: Bool = false

    @State private var showICloudAlert: Bool = false
    @State private var showICloudDeleteAlert: Bool = false

    var body: some View {
        Section(
            header: Label("Data", systemImage: "arrow.up.arrow.down"),
            footer: footer
        ) {
            ICloudButton
            
            Button {
                fileImporterIsOpen = true
            } label: {
                Label(
                    "Import from CSV File",
                    systemImage: "square.and.arrow.down"
                )
            }
            .fileImporter(
                isPresented: $fileImporterIsOpen,
                allowedContentTypes: [.plainText]
            ) { result in
                Task {
                    let contents = await backupManager.generateContentsFromFile(result)
                    await contentVM.importContents(contents: contents)
                }
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
                    systemImage: "square.and.arrow.up"
                )
            }
            .preference(key: LoadingPreferenceKey.self, value: backupManager.isLoading)
            .preference(key: ErrorPreferenceKey.self, value: backupManager.errorMessage)
            .preference(key: InfoPreferenceKey.self, value: contentVM.infoMessage)
        }
        .headerProminence(.increased)
        .sheet(item: $exportUrl, onDismiss: {
            
        }, content: { exportUrl in
            ActivityViewController(exportUrl: exportUrl)
        })
    }
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
    private var ICloudButton: some View {
        Button {
            showICloudAlert.toggle()
        } label: {
            Label(
                settingsVM.iCloudEnabled ? "iCloud Sync enabled" : "iCloud Sync disabled",
                systemImage: settingsVM.iCloudEnabled ? "checkmark.icloud.fill" : "xmark.icloud.fill"
            )
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.green)
        }
        .alert(
            settingsVM.iCloudEnabled ? "Synchronization with iCloud is enabled" : "Synchronization with iCloud is disabled",
            isPresented: $showICloudAlert
        ) {
            Button("Cancel", role: .cancel) {
                showICloudAlert = false
            }
            
            Button(settingsVM.iCloudEnabled ? "Disable" : "Enable", role: .destructive) {
                showICloudDeleteAlert.toggle()
            }
        } message: {
            if settingsVM.iCloudEnabled {
                Text("Do you want to turn off syncing with iCloud? This will result in the loss of all currently stored content.")
            } else {
                Text("Do you want to sync with iCloud? This will overwrite all currently saved content.")
            }
        }
        .alert(
            settingsVM.iCloudEnabled ? "Disable iCloud" : "Enable iCloud",
            isPresented: $showICloudDeleteAlert
        ) {
            Button("Cancel", role: .cancel) {
                showICloudAlert = false
            }
            
            Button(settingsVM.iCloudEnabled ? "Disable" : "Enable", role: .destructive) {
                settingsVM.toggleICloudEnabled()
            }
        } message: {
            if settingsVM.iCloudEnabled {
                Text("Are you sure you want to stop syncing with iCloud? This will result in the loss of all currently stored content. You will need to restart the application for this to happen.")
            } else {
                Text("Are you sure you want to start syncing with iCloud? This will result in the loss of all currently stored content. You will need to restart the application for this to happen.")
            }
        }
    }
    
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
