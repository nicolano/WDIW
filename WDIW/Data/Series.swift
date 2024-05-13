//
//  Series.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation
import SwiftData

/// A `MediaContent` that is used for series.
///
/// - Parameters:
///   - name: The name of the series.
///   - date: The date the series was watched/added to the database.
///   - additionalInfo: For series, this can for example specify which seasons where watched.
///   - rating: The rating of the series, which should be in a range from 1 to 10.
///   - url: The Imdb id.
@Model class Series: MediaContent {
    @Attribute(.unique) var id: UUID
    var name: String
    var additionalInfo: String
    var date: Date
    var rating: Int
    var url: String

    init(id: UUID, name: String, additionalInfo: String, entryDate: Date, rating: Int, url: String) {
        self.id = id
        self.additionalInfo = additionalInfo
        self.name = name
        self.date = entryDate
        self.rating = rating
        self.url = url
    }
    
    init(name: String, additionalInfo: String, entryDate: Date, rating: Int, url: String) {
        self.id = UUID()
        self.additionalInfo = additionalInfo
        self.name = name
        self.date = entryDate
        self.rating = rating
        self.url = url
    }
    
    static var empty: Series {
        return Series(name: "", additionalInfo: "", entryDate: Date(), rating: -1, url: "")
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
    
    var asString: String {
        "\(self.name), \(self.date.ISO8601Format()), \(self.additionalInfo), \(self.rating), \(self.url)"
    }
}
