//
//  Season.swift
//  WDIW
//
//  Created by Nicolas von Trott on 05.02.25.
//

import SwiftData
import Foundation

struct Seasons: Codable {
    var totalSeasons: Int = 1
    var watchedSeasons: [Int] = []
    
    init(totalSeasons: Int = 1, watchedSeasons: [Int] = []) {
        self.totalSeasons = totalSeasons
        self.watchedSeasons = watchedSeasons
    }
    
    mutating func addOrRemoveWatchedSeason(_ season: Int) {
        if watchedSeasons.contains(season) {
            watchedSeasons.removeAll { $0 == season }
            return
        }
        watchedSeasons.append(season)
    }
    
    mutating func increaseTotalSeasons() {
        totalSeasons += 1
    }
    
    mutating func decreaseTotalSeasons() {
        guard totalSeasons > 1 else { return }
        totalSeasons -= 1
        
        for watchedSeason in watchedSeasons {
            if watchedSeason > totalSeasons {
                watchedSeasons.removeAll { $0 == watchedSeason }
            }
        }
    }
    
    func getSeasonsDesc() -> String {
        if isMiniSeries {
            return "Mini Series"
        }
        
        var desc = "Season "
        for season in watchedSeasons {
            desc.append("\(season)")
            if season != watchedSeasons.last {
                desc.append(", ")
            }
        }
        
        return desc
    }
    
    var isMiniSeries: Bool {
        return watchedSeasons.isEmpty || totalSeasons == 1
    }
    
    func asString() -> String {
        var string = "\(totalSeasons)$"
        for watchedSeason in watchedSeasons.uniqued().sorted() {
            string += "\(watchedSeason)$"
        }
        
        return string
    }
    
    static func fromString(_ seasonString: String) -> Seasons {
        var elements = seasonString.split(separator: "$")
        if elements.isEmpty {
            return Seasons()
        }

        var seasons = Seasons(totalSeasons: Int(elements.removeFirst()) ?? 1)
        for element in elements {
            seasons.addOrRemoveWatchedSeason(Int(element) ?? 0)
        }
        
        return seasons
    }
}
