//
//  Content.swift
//  WDIW
//
//  Created by Nicolas von Trott on 04.02.25.
//

import SwiftData
import Foundation

@Model class ContentMedia {
    var name: String?
    var contentCategory: ContentCategories?
    var contentEntries: [ContentEntry]?
    var createdBy: [Creator]?
    
    init(name: String, contentCategory: ContentCategories, createdBy: [Creator]) {
        self.name = name
        self.contentCategory = contentCategory
        self.createdBy = createdBy
    }
}
