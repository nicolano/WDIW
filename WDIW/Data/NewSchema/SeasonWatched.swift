//
//  SeasonWatched.swift
//  WDIW
//
//  Created by Nicolas von Trott on 04.02.25.
//

import SwiftData
import Foundation

@Model class SeasonWatched {
    var contentEntry: ContentEntry?
    var season: Int?

    init(contentEntry: ContentEntry, season: Int) {
        self.contentEntry = contentEntry
        self.season = season
    }
}
