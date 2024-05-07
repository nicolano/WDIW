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
}
