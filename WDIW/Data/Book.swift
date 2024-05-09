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
    var additionalInfo: String
    var date: Date
    var rating: Int
    var url: String

    init(id: UUID, name: String, entryDate: Date, author: String, isFavorite: Bool, url: String) {
        self.id = id
        self.name = name
        self.date = entryDate
        self.additionalInfo = author
        self.rating = isFavorite ? 1 : 0
        self.url = url
    }
    
    init(name: String, entryDate: Date, author: String, isFavorite: Bool, url: String) {
        self.id = UUID()
        self.name = name
        self.date = entryDate
        self.additionalInfo = author
        self.rating = isFavorite ? 1 : 0
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
        
        if additionalInfo == "" {
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
            self.additionalInfo
        }
        set {
            self.additionalInfo = newValue
        }
    }

    var asString: String {
        "\(self.name), \(self.date.ISO8601Format()), \(self.author), \(self.url)"
    }
}
