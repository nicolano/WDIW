//
//  ContentCategories.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation

enum ContentCategories: Equatable, Codable {
    case books, movies, series
}

extension ContentCategories {
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
    
    static var iterator: [ContentCategories] = [.books, .movies, .series]
}
