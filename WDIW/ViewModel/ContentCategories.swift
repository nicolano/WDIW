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
            "Bücher"
        case .movies:
            "Filme"
        case .series:
            "Serien"
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
}
