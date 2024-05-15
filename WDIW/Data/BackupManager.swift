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

enum ErrorAccessingFile: Error {
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
            
            let heading = "Category;Id;Name;Date;Creator;Additional Info;Rating;Url;Image Url\n"
            let rows = contents.map {
                let category = ContentCategories.getCategoryFor(mediaContent: $0).getName()
                let id = $0.id
                let name = $0.name
                let creator = $0.creator
                let date = $0.date.ISO8601Format()
                let additionalInfo = $0.additionalInfo
                let rating = String($0.rating)
                let url = $0.url
                let imageUrl = $0.imageUrl
                
                return "\(category);\(id);\(name);\(date);\(creator);\(additionalInfo);\(rating);\(url);\(imageUrl)"
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
            let content = await getContentFromFile(url: file.absoluteURL)
            
            
            isLoading = false
            if let content = content, content.isEmpty {
                await self.showErrorMessage("We could not extract any data from the file. Make sure that the file is formatted correctly and try again.")
            }
            
            return content ?? []
        case .failure(let error):
            await self.showErrorMessage(error.localizedDescription)
        }
        
        isLoading = false
        return []
    }
    
    private func getContentFromFile(url: URL) async -> [MediaContent]? {
        var errorMappingContentCount = 0
        
        guard url.startAccessingSecurityScopedResource() else {
            print("startAccessingSecurityScopedResource returned false")
            await self.showErrorMessage("We could not open the file")
            return nil
        }

        var content = ""
        do {
            content = try String(contentsOf: url)
        } catch {
            print(error)
            await self.showErrorMessage("We could not open the file")
            return nil
        }
        
        var parsedCSV: [[String]] = content
            .components(separatedBy: "\n")
            .map { return $0.components(separatedBy: ";") }
        // Remove first line
        parsedCSV.remove(at: 0)
        
        var mappedContents: [MediaContent] = []
        do {
            for line in parsedCSV {
                mappedContents.append(try mapConentent(from: line))
            }
        } catch {
            if errorMappingContentCount == 0 {
                await self.showErrorMessage("We could not import all contents from the file")
            }
            errorMappingContentCount += 1
        }
        
        return mappedContents
    }
    
    private func mapConentent(from: [String]) throws -> MediaContent {
        do {
            let content: MediaContent
            let category = from[0]
            switch category {
            case ContentCategories.books.getName():
                content = Book(
                    id: UUID(uuidString: from[1]) ?? UUID(),
                    name: from[2],
                    entryDate: try Date.ISO8601FormatStyle().parse(from[3]),
                    author: from[4],
                    additionalInfo: from[5],
                    isFavorite: Int(from[6])! > 0,
                    url: from[7]
                )
            case ContentCategories.books.getSingularName():
                content = Book(
                    id: UUID(uuidString: from[1]) ?? UUID(),
                    name: from[2],
                    entryDate: try Date.ISO8601FormatStyle().parse(from[3]),
                    author: from[4],
                    additionalInfo: from[5],
                    isFavorite: Int(from[6])! > 0,
                    url: from[7]
                )
            case ContentCategories.movies.getName():
                content = Movie(
                    id: UUID(uuidString: from[1]) ?? UUID(),
                    name: from[2],
                    director: from[4],
                    additionalInfo: from[5],
                    watchDate: try Date.ISO8601FormatStyle().parse(from[3]),
                    rating: Int(from[6])!,
                    url: from[7]
                )
            case ContentCategories.movies.getSingularName():
                content = Movie(
                    id: UUID(uuidString: from[1]) ?? UUID(),
                    name: from[2],
                    director: from[4],
                    additionalInfo: from[5],
                    watchDate: try Date.ISO8601FormatStyle().parse(from[3]),
                    rating: Int(from[6])!,
                    url: from[7]
                )
            case ContentCategories.series.getName():
                content = Series(
                    id: UUID(uuidString: from[1]) ?? UUID(),
                    name: from[2],
                    directors: from[4],
                    additionalInfo: from[5],
                    entryDate: try Date.ISO8601FormatStyle().parse(from[3]),
                    rating: Int(from[6])!,
                    url: from[7]
                )
            default:
                print("Could not determine category for: \(from)")
                throw ErrorMappingContentFromString.runtimeError("Could not determine category for: \(from)")
            }
            
            return content
        } catch {
            print("Error mapping content for: \(from)")
            throw ErrorMappingContentFromString.runtimeError("Error mapping content for: \(from)")
        }
    }
}




