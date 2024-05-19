//
//  Array.swift
//  WDIW
//
//  Created by Nicolas von Trott on 18.05.24.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
