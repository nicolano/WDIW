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
class Series: MediaContent {
    var id: UUID = UUID()
    var name: String = ""
    var creator: String = ""
    var additionalInfo: String = ""
    var date: Date = Date.distantPast
    var rating: Int = -1
    var url: String = ""
    var imageUrl: String = ""

    init(_ contentEntry: ContentEntry) {
        self.name = contentEntry.content?.name ?? ""
        self.date = contentEntry.date ?? Date.distantPast
        for creator in contentEntry.content?.createdBy ?? [] {
            self.creator += "\(creator.name ?? "") "
        }
        self.additionalInfo = contentEntry.userNotes ?? ""
        self.rating = (contentEntry.userRating ?? 0)
    }
    
    init(name: String, directors: String, additionalInfo: String, entryDate: Date, rating: Int, url: String) {
        self.id = UUID()
        self.creator = directors
        self.additionalInfo = additionalInfo
        self.name = name
        self.date = entryDate
        self.rating = rating
        self.url = url
    }
    
    static var empty: Series {
        return Series(name: "", directors: "", additionalInfo: "", entryDate: Date(), rating: -1, url: "")
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
    var directors: String {
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
