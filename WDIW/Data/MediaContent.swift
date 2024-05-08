//
//  Content.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//
import Foundation
import SwiftData

protocol MediaContent {
    var id: UUID { get }
    var name: String { get }
    var entryDate: Date { get }
    var url: String { get }
    
    var isValid: Bool { get }
}
