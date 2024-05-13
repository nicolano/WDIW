//
//  BackupManager.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.02.24.
//

import Foundation
import SwiftUI

enum ErrorMappingContentFromString: Error {
    case runtimeError(String)
}

@MainActor
class BackupManager: ObservableObject {
    @Published var isLoading: Bool = false
    
    let fileManager = FileManager.default
    
    @Published var errorMessage: String? = nil
    private func showErrorMessage(_ text: String) async {
        errorMessage = text
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        errorMessage = nil
    }
    
    func generateCSVFileFromContents(contents: [MediaContent]) async -> URL? {
        if contents.isEmpty {
            await showErrorMessage("You have no data stored in the app.")
            return nil
        }
        
        isLoading = true
        do {
            // Add delay so loading animation looks nice
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            
            let heading = "Category,Id,Name,Date,Additional Info,Rating,Url\n"
            let rows = contents.map {
                let category = ContentCategories.getCategoryFor(mediaContent: $0).getName()
                let id = $0.id
                let name = $0.name
                let date = $0.date.ISO8601Format()
                let additionalInfo = $0.additionalInfo
                let rating = String($0.rating)
                let url = $0.url
                
                return "\(category),\(id),\(name),\(date),\(additionalInfo),\(rating),\(url)"
            }
            
            let stringData = heading + rows.joined(separator: "\n")
            let path = try FileManager.default.url(
                for: .documentDirectory,
                in: .allDomainsMask,
                appropriateFor: nil,
                create: false
            )
            
            let dateAppendix = Date.now.formattedForFileName()
            let fileURL = path.appendingPathComponent("WDIW_Backup_\(dateAppendix).csv")
            try stringData.write(to: fileURL, atomically: false , encoding: .utf8)
            
            isLoading = false
            return fileURL
        } catch {  
            isLoading = false
            Task { await self.showErrorMessage("Failed to create CSV File. Please try again.") }
            return nil
        }
    }
    
    func generateContentsFromFile(_ result: Result<URL, any Error>) async -> [MediaContent] {
        isLoading = true
        // Add delay so loading animation looks nice
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        switch result {
        case .success(let file):
            let content = getContentFromFile(url: file.absoluteURL)
            
            
            isLoading = false
            if content.isEmpty {
                await self.showErrorMessage("We could not extract any data from the file. Make sure that the file is formatted correctly and try again.")
            }
            
            return content
        case .failure(let error):
            await self.showErrorMessage(error.localizedDescription)
        }
        
        isLoading = false
        return []
    }
    
    private func getContentFromFile(url: URL) -> [MediaContent] {
        do {
            let content = try String(contentsOf: url)
            var parsedCSV: [[String]] = content
                .components(separatedBy: "\n")
                .map { return $0.components(separatedBy: ",") }
            // Remove first line
            parsedCSV.remove(at: 0)
            
            var mappedContents: [MediaContent] = []
            for line in parsedCSV {
                mappedContents.append(try mapConentent(from: line))
            }
            
            return mappedContents
        } catch is ErrorMappingContentFromString {
            return []
        } catch {
            return []
        }
    }
    
    private func mapConentent(from: [String]) throws -> MediaContent {
        do {
            let content: MediaContent
            let category = from[0]
            switch category {
            case ContentCategories.books.getName():
                content = Book(
                    id: UUID(uuidString: from[1])!,
                    name: from[2],
                    entryDate: try Date.ISO8601FormatStyle().parse(from[3]),
                    author: from[4],
                    isFavorite: Int(from[5])! > 0,
                    url: from[6]
                )
            case ContentCategories.movies.getName():
                content = Movie(
                    id: UUID(uuidString: from[1])!,
                    name: from[2],
                    director: from[4],
                    watchDate: try Date.ISO8601FormatStyle().parse(from[3]),
                    rating: Int(from[5])!,
                    url: from[6]
                )
                
            case ContentCategories.series.getName():
                content = Series(
                    id: UUID(uuidString: from[1])!,
                    name: from[2],
                    additionalInfo: from[4],
                    entryDate: try Date.ISO8601FormatStyle().parse(from[3]),
                    rating: Int(from[5])!,
                    url: from[6]
                )
            default:
                throw ErrorMappingContentFromString.runtimeError("Could not determine category for: \(from)")
            }
            
            return content
        } catch {
            throw ErrorMappingContentFromString.runtimeError("Error mapping content for: \(from)")
        }
    }
}




