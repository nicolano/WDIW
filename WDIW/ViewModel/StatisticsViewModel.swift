//
//  StatisticsViewModel.swift
//  WDIW
//
//  Created by Nicolas von Trott on 31.01.25.
//

import Foundation

struct ContentStatistic {
    var booksCount: Int
    var moviesCount: Int
    var seriesCount: Int
    
    mutating func countItem(category: ContentCategories) {
        switch category {
        case .books:
            self.booksCount += 1
        case .movies:
            self.moviesCount += 1
        case .series:
            self.seriesCount += 1
        }
    }
}

@MainActor
class StatisticsViewModel: ObservableObject {
    internal init(contentVM: ContentViewModel) {
        self.contentVM = contentVM
    }
    
    let contentVM: ContentViewModel
    
    var totalStatistics: ContentStatistic {
        ContentStatistic(
            booksCount: contentVM.books.count,
            moviesCount: contentVM.movies.count,
            seriesCount: contentVM.series.count
        )
    }
    
    var yearStatistics: [String: ContentStatistic] {
        var yearStatistics: [String: ContentStatistic] = [:]
        for content in contentVM.mediaContents {
            let components = Calendar.current.dateComponents([Calendar.Component.year], from: content.date)
            let year = components.year?.description ?? ""
            
            
            
            if !yearStatistics.keys.contains(year) {
                switch content {
                case is Book:
                    yearStatistics.updateValue(
                        ContentStatistic(booksCount: 1, moviesCount: 0, seriesCount: 0), forKey: year
                    )
                case is Movie:
                    yearStatistics.updateValue(
                        ContentStatistic(booksCount: 0, moviesCount: 1, seriesCount: 0), forKey: year
                    )
                case is Series:
                    yearStatistics.updateValue(
                        ContentStatistic(booksCount: 0, moviesCount: 0, seriesCount: 1), forKey: year
                    )
                default:
                    break
                }
            } else {
                var yearStatistic = yearStatistics[year]!
                switch content {
                case is Book:
                    yearStatistic.countItem(category: .books)
                case is Movie:
                    yearStatistic.countItem(category: .movies)
                case is Series:
                    yearStatistic.countItem(category: .series)
                default:
                    break
                }
                
                yearStatistics.updateValue(yearStatistic, forKey: year)
            }
        }
        
        return yearStatistics
    }
}
