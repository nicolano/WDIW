//
//  Movie.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation
import SwiftData

@Model
class Movie: MediaContent {
    @Attribute(.unique) var id: UUID
    var name: String
    var watchDate: Date
    var entryDate: Date
    var rating: Double
    var url: String

    init(id: UUID, name: String, watchDate: Date, entryDate: Date, rating: Double, url: String) {
        self.id = id
        self.name = name
        self.watchDate = watchDate
        self.entryDate = entryDate
        self.rating = rating
        self.url = url
    }
    
    init(name: String, watchDate: Date, entryDate: Date, rating: Double, url: String) {
        self.id = UUID()
        self.name = name
        self.watchDate = watchDate
        self.entryDate = entryDate
        self.rating = rating
        self.url = url
    }
    
    static var empty: Movie {
        return Movie(name: "", watchDate: Date(), entryDate: Date(), rating: -1, url: "")
    }
    
    /// Returns true if the `name` and `rating` field of the movie has an non empty value.
    var isValid: Bool {
        if name == "" {
            return false
        }
        
        if rating < 0 {
            return false
        }
        
        return true
    }
}
