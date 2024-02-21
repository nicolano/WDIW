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
    @Attribute(.externalStorage, .allowsCloudEncryption) var image: Data?

    var rating: Double
    
    init(id: UUID, name: String, watchDate: Date, image: Data? = nil, rating: Double) {
        self.id = id
        self.name = name
        self.watchDate = watchDate
        self.image = image
        self.rating = rating
    }
}
