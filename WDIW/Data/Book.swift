//
//  Book.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation
import SwiftData

@Model
class Book: MediaContent {
    @Attribute(.unique) var id: UUID
    var name: String
    var entryDate: Date
    var author: String
    var isFavorite: Bool
    var url: String

    init(id: UUID, name: String, entryDate: Date, author: String, isFavorite: Bool, url: String) {
        self.id = id
        self.name = name
        self.entryDate = entryDate
        self.author = author
        self.isFavorite = isFavorite
        self.url = url
    }
    
    init(name: String, entryDate: Date, author: String, isFavorite: Bool, url: String) {
        self.id = UUID()
        self.name = name
        self.entryDate = entryDate
        self.author = author
        self.isFavorite = isFavorite
        self.url = url
    }
    
    static var empty: Book {
        return Book(name: "", entryDate: Date.now, author: "", isFavorite: false, url: "")
    }
    
    /// Returns true if the `name` and `author` field of the book has an non empty value.
    var isValid: Bool {
        if name == "" {
            return false
        }
        
        if author == "" {
            return false
        }
        
        return true
    }

    var asString: String {
        "\(self.name), \(self.entryDate.ISO8601Format()), \(self.author), \(self.url)"
    }
}
