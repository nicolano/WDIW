//
//  ContentCategories.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation

enum ContentCategories {
    case books, movies, series
    
    func getName() -> String {
        switch self {
        case .books:
            "Books"
        case .movies:
            "Movies"
        case .series:
            "Series"
        }
    }
    
    func getSingularName() -> String {
        switch self {
        case .books:
            "Book"
        case .movies:
            "Movie"
        case .series:
            "Series"
        }
    }
    
    func getIconName(isActive: Bool) -> String {
        switch self {
        case .books:
            isActive ? "book.fill" : "book"
        case .movies:
            isActive ? "movieclapper.fill" : "movieclapper"
        case .series:
            isActive ? "film.stack.fill" : "film.stack"
        }
    }
    
    var getEmptyContent: MediaContent {
        switch self {
        case .books:
            return Book.empty
        case .movies:
            return Movie.empty
        case .series:
            return Series.empty
        }
    }
    
    static func getCategoryFor(mediaContent: MediaContent) -> ContentCategories {
        if mediaContent is Book {
            return .books
        }
        
        if mediaContent is Movie {
            return .movies
        }
        
        if mediaContent is Series {
            return .series
        }
        
        fatalError("Could not determine category of media content")
    }
}
