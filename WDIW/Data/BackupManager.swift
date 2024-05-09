//
//  BackupManager.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.02.24.
//

import Foundation

class BackupManager: ObservableObject {
    @Published var isLoading = false
    
    let fileManager = FileManager.default
    
    func generateCSVFileFromContents(contents: [MediaContent]) throws -> URL {
        self.isLoading = true

        let heading = "Category, Id, Name, Date, Additional Info, Rating, Url\n"
        let rows = contents.map {
            let category = ContentCategories.getCategoryFor(mediaContent: $0).getName()
            let id = $0.id
            let name = $0.name
            let date = $0.date.ISO8601Format()
            let additionalInfo = $0.additionalInfo
            let rating = String($0.rating)
            let url = $0.url
            
            return " \(category), \(id), \(name), \(date), \(additionalInfo), \(rating), \(url)\n"
        }
        
        let stringData = heading + rows.joined(separator: "\n")
        do {
            let path = try FileManager.default.url(
                for: .documentDirectory,
                in: .allDomainsMask,
                appropriateFor: nil,
                create: false
            )
            
            let dateAppendix = Date.now.formattedForFileName()
            let fileURL = path.appendingPathComponent("WDIW_Backup_\(dateAppendix).csv")
            try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            
            self.isLoading = false
            return fileURL
        } catch {
            self.isLoading = false
            throw fatalError("error generating csv file")
        }
    }

    func writeToFile(data: Data, filePath: String) {
        let success = fileManager.createFile(atPath: filePath, contents: data)
        if success {
            print("File created and data written successfully.")
        } else {
            print("Failed to create file.")
        }
    }
    
    func readFromFile(filePath: String) throws -> Data {
        return fileManager.contents(atPath: filePath)!
    }
}


