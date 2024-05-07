//
//  Date.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.02.24.
//

import Foundation

extension Date {
    func formattedForFileName() -> String {
        let components = Calendar.current.dateComponents(in: .current, from: self)
        let year = components.year?.description ?? "0"
        let month = components.month?.description ?? "0"
        let day = components.day?.description ?? "0"
        let hour = components.hour?.description ?? "0"
        let minute = components.minute?.description ?? "0"

        return "\(year)_\(month)_\(day)_\(hour)_\(minute)"
    }
}
