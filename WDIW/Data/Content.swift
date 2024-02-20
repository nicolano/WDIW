//
//  Content.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//
import Foundation
import SwiftData

protocol Content {
    var id: UUID { get }
    var name: String { get }
    var watchDate: Date { get }
    var image: Data? { get }
}
