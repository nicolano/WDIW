//
//  Book.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation
import SwiftData

@Model
class Book: MediaContent {
    @Attribute(.unique) var id: UUID
    var name: String
    var watchDate: Date
    var entryDate: Date
    var author: String
    @Attribute(.externalStorage, .allowsCloudEncryption) var image: Data?

    init(id: UUID, name: String, watchDate: Date, entryDate: Date, author: String, image: Data? = nil) {
        self.id = id
        self.name = name
        self.watchDate = watchDate
        self.entryDate = entryDate
        self.author = author
        self.image = image
    }
}
