//
//  Content.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//
import Foundation
import SwiftData

protocol MediaContent {
    // Stored properties
    var id: UUID { get }
    var date: Date { get }
    var name: String { get }
    var url: String { get }
    var imageUrl: String { get }
    var creator: String { get }
    var additionalInfo: String { get }
    var rating: Int { get }
    
    // Computed properties
    var isValid: Bool { get }
    var asString: String { get }
    
    func copy() -> MediaContent
}
