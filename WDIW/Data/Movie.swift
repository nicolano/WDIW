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
    var id: UUID = UUID()
    var name: String = ""
    var creator: String = ""
    var additionalInfo: String = ""
    var date: Date = Date.distantPast
    var rating: Int = -1
    var url: String = ""
    var imageUrl: String = ""

    init(id: UUID, name: String, director: String, additionalInfo: String, watchDate: Date, rating: Int, url: String) {
        self.id = id
        self.name = name
        self.creator = director
        self.additionalInfo = additionalInfo
        self.date = watchDate
        self.rating = rating
        self.url = url
    }
    
    init(name: String, director: String, additionalInfo: String, watchDate: Date, rating: Int, url: String) {
        self.id = UUID()
        self.name = name
        self.date = watchDate
        self.creator = director
        self.additionalInfo = additionalInfo
        self.rating = rating
        self.url = url
    }
    
    static var empty: Movie {
        return Movie(name: "", director: "", additionalInfo: "", watchDate: Date(), rating: -1, url: "")
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
    
    /// Mask for the additional info field, which is the author.
    var director: String {
        get {
            self.creator
        }
        set {
            self.creator = newValue
        }
    }
    
    var asString: String {
        "\(self.name), \(self.date.ISO8601Format()), \(self.creator), \(self.additionalInfo), \(self.rating), \(self.url)"
    }
}
