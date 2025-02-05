//
//  BookEntry.swift
//  WDIW
//
//  Created by Nicolas von Trott on 04.02.25.
//

import SwiftData
import Foundation

@Model class ContentEntry {
    var content: ContentMedia?
    var seasonsWatched: [SeasonWatched]?
    var date: Date?
    var userRating: Int?
    var userNotes: String?
    
    init(content: ContentMedia?, seasonsWatched: [SeasonWatched], date: Date, userRating: Int, userNotes: String) {
        self.content = content
        self.seasonsWatched = seasonsWatched
        self.date = date
        self.userRating = userRating
        self.userNotes = userNotes
    }
    
    static func getEmptyFor(category: ContentCategories) -> ContentEntry {
        return ContentEntry(
            content: ContentMedia(
                name: "",
                contentCategory: category,
                createdBy: []),
            seasonsWatched: [],
            date: Date.distantPast,
            userRating: -1,
            userNotes: ""
        )
    }
    
    var isValid: Bool {
        if content?.name == "" {
            return false
        }
        
        switch self.content?.contentCategory {
        case .books:
            if (content?.createdBy ?? []).isEmpty {
                return false
            }
            
            return true
        case .movies:
            if self.userRating ?? 0 < 0 {
                return false
            }
            
            return true
        case .series:
            if self.userRating ?? 0 < 0 {
                return false
            }
            
            return true
        case nil:
            return false
        }
    }
}
