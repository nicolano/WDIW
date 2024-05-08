//
//  BackupManager.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.02.24.
//

import Foundation

class BackupManager: ObservableObject {
    @Published var isLoading = false
//    
//    let fileManager = FileManager.default
//    
////    func createBackupFromContent(contents: [MediaContent], pathToFile: String) {
////        var fileString = ""
////        for content in contents {
////            
////        }
////        
////        
////    }
////    
//    func generateCSVFileFromContents(contents: [MediaContent]) throws -> URL {
//        self.isLoading = true
//        
//        let heading = "Category, Name, Watch Date, Entry Date, Author, Rating, Url\n"
//        let rows = contents.map {
//            switch $0 {
//            case is Book:
//                let book = $0 as! Book
//                return "\(ContentCategories.books.getName()),\(book.watchDate.ISO8601Format()),\(book.entryDate.ISO8601Format()), \(book.author),\(book.rating),\(book.url)\n"
//            case is Movie:
//                let book = $0 as! Movie
//                return "\(ContentCategories.movies.getName()),\(book.watchDate.ISO8601Format()),\(book.entryDate.ISO8601Format()), nil,\(book.rating),\(book.url)\n"
//            case is Series:
//                let book = $0 as! Series
//                return "\(ContentCategories.series.getName()),\(book.watchDate.ISO8601Format()),\(book.entryDate.ISO8601Format()), nil,\(book.rating),\(book.url)\n"
//            default:
//                return ""
//            }
//        }
//        
//        let stringData = heading + rows.joined(separator: "\n")
//        do {
//            let path = try FileManager.default.url(
//                for: .documentDirectory,
//                in: .allDomainsMask,
//                appropriateFor: nil,
//                create: false
//            )
//            
//            let dateAppendix = Date.now.formattedForFileName()
//            let fileURL = path.appendingPathComponent("WDIW_Backup_\(dateAppendix).csv")
//            try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
//            
//            self.isLoading = false
//            return fileURL
//        } catch {
//            self.isLoading = false
//            throw fatalError("error generating csv file")
//        }
//    }
//
////    func writeToFile(data: Data, filePath: String) {
////        let success = fileManager.createFile(atPath: filePath, contents: data)
////        if success {
////            print("File created and data written successfully.")
////        } else {
////            print("Failed to create file.")
////        }
////    }
////    
////    func readFromFile(filePath: String) throws -> Data {
////        return fileManager.contents(atPath: filePath)!
////    }
}


