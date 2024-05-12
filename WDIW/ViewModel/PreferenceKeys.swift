//
//  IsLoadingPreferenceKey.swift
//  WDIW
//
//  Created by Nicolas von Trott on 12.05.24.
//

import SwiftUI

struct LoadingPreferenceKey: PreferenceKey {
    static var defaultValue: Bool? = nil
    static func reduce(value: inout Bool?, nextValue: () -> Bool?) {
        value = value ?? nextValue()
    }
}

struct ErrorPreferenceKey: PreferenceKey {
    static var defaultValue: String? = nil
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = value ?? nextValue()
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}
