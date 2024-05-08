//
//  Series.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation
import SwiftData

@Model
class Series: MediaContent {
    @Attribute(.unique) var id: UUID
    var name: String
    var additionalInfos: String
    var entryDate: Date
    var rating: Double
    var url: String

    init(id: UUID, name: String, additionalInfos: String, entryDate: Date, rating: Double, url: String) {
        self.id = id
        self.additionalInfos = additionalInfos
        self.name = name
        self.entryDate = entryDate
        self.rating = rating
        self.url = url
    }
    
    init(name: String, additionalInfos: String, entryDate: Date, rating: Double, url: String) {
        self.id = UUID()
        self.additionalInfos = additionalInfos
        self.name = name
        self.entryDate = entryDate
        self.rating = rating
        self.url = url
    }
    
    static var empty: Series {
        return Series(name: "", additionalInfos: "", entryDate: Date(), rating: -1, url: "")
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
