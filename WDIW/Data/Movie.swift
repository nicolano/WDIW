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
    var url: Double

    init(id: UUID, name: String, watchDate: Date, entryDate: Date, rating: Double, url: Double) {
        self.id = id
        self.name = name
        self.watchDate = watchDate
        self.entryDate = entryDate
        self.rating = rating
        self.url = url
    }
}
