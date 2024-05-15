//
//  Book.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation
import SwiftData

/// A `MediaContent` that is used for books.
///
/// - Parameters:
///   - name: The name of the book.
///   - date: The date the book was read/added to the database.
///   - additionalInfo: For books, this is usually the author (can be accessed via `author` parameter). 
///   - rating: The rating of the book, if greater than zero, the book counts as a favourite, accessible under `isFavourite`.
///   - url: ??
@Model class Book: MediaContent {
    @Attribute(.unique) var id: UUID
    var name: String
    var creator: String
    var additionalInfo: String
    var date: Date
    var rating: Int
    var url: String
    var imageUrl: String = ""

    init(id: UUID, name: String, entryDate: Date, author: String, additionalInfo: String, isFavorite: Bool, url: String) {
        self.id = id
        self.name = name
        self.date = entryDate
        self.creator = author
        self.additionalInfo = additionalInfo
        self.rating = isFavorite ? 1 : 0
        self.url = url
    }
    
    init(name: String, entryDate: Date, author: String, additionalInfo: String, isFavorite: Bool, url: String) {
        self.id = UUID()
        self.name = name
        self.date = entryDate
        self.creator = author
        self.additionalInfo = additionalInfo
        self.rating = isFavorite ? 1 : 0
        self.url = url
    }
    
    static var empty: Book {
        return Book(name: "", entryDate: Date.now, author: "", additionalInfo: "", isFavorite: false, url: "")
    }
    
    /// Returns true if the `name` and `creator` field of the book has an non empty value.
    var isValid: Bool {
        if name == "" {
            return false
        }
        
        if creator == "" {
            return false
        }
        
        return true
    }
    
    /// A book counts as a favorite if the rating is set to larger 0
    var isFavorite: Bool { 
        get {
            return rating > 0
        }
        set {
            rating = newValue ? 1 : 0
        }
    }
    
    /// Mask for the additional info field, which is the author.
    var author: String {
        get {
            self.creator
        }
        set {
            self.creator = newValue
        }
    }

    var asString: String {
        "\(self.name), \(self.date.ISO8601Format()), \(self.author), \(self.additionalInfo), \(self.isFavorite), \(self.url)"
    }
}
