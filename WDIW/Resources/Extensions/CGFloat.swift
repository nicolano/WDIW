//
//  CGFloat.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation
import SwiftUI

extension CGFloat {
    public struct Spacing {
        public static var xxs: CGFloat = 2
        public static var xs: CGFloat = 4
        public static var s: CGFloat = 8
        public static var m: CGFloat = 16
        public static var l: CGFloat = 32
        public static var xl: CGFloat = 64
    }
    
    public struct CornerRadius {
        public static var textField: CGFloat = 8
        public static var contentItem: CGFloat = 10
        public static var dialog: CGFloat = 20
    }
    
    static var offsetNavToSettings: CGFloat = 80.0
}
