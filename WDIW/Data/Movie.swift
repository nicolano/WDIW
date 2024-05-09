//
//  Movie.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation
import SwiftData

/// A `MediaContent` that is used for movies.
///
/// - Parameters:
///   - name: The name of the movie.
///   - date: The date the movie was watched/added to the database.
///   - additionalInfo: For movies, this is usually the director.
///   - rating: The rating of the movie, which should be in a range from 1 to 10.
///   - url: The Imdb id.
@Model class Movie: MediaContent {
    @Attribute(.unique) var id: UUID
    var name: String
    var additionalInfo: String
    var date: Date
    var rating: Int
    var url: String

    init(id: UUID, name: String, director: String, watchDate: Date, rating: Int, url: String) {
        self.id = id
        self.name = name
        self.additionalInfo = director
        self.date = watchDate
        self.rating = rating
        self.url = url
    }
    
    init(name: String, director: String, watchDate: Date, rating: Int, url: String) {
        self.id = UUID()
        self.name = name
        self.date = watchDate
        self.additionalInfo = director
        self.rating = rating
        self.url = url
    }
    
    static var empty: Movie {
        return Movie(name: "", director: "", watchDate: Date(), rating: -1, url: "")
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
