//
//  Creator.swift
//  WDIW
//
//  Created by Nicolas von Trott on 04.02.25.
//

import SwiftData
import Foundation

@Model class Creator {
    var name: String?
    var created: [ContentMedia]?
    
    init(name: String?) {
        self.name = name
    }
}
