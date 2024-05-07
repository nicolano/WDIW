//
//  Text.swift
//  WDIW
//
//  Created by Nicolas von Trott on 29.02.24.
//

import Foundation
import SwiftUI

extension VStack {
    static func spacingM(
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> VStack {
        VStack(alignment: alignment, spacing: 10, content: content)
    }
    
    static func zeroSpacing(
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> VStack {
        VStack(alignment: alignment, spacing: 0, content: content)
    }
}

public enum PaddingTypes {
    case TopXS, TopS, TopM, TopL, TopXL, 
         BottomXS, BottomS, BottomM, BottomL, BottomXL,
         LeadingXS, LeadingS, LeadingM, LeadingL, LeadingXL,
         TrailingXS, TrailingS, TrailingM, TrailingL, TrailingXL,
         VerticalXS, VerticalS, VerticalM, VerticalL, VerticalXL,
         HorizontalXS, HorizontalS, HorizontalM, HorizontalL, HorizontalXL
}

extension View {
    @inlinable public func padding(_ type: PaddingTypes) -> some View {
        switch type {
        case .TopXS:
            self.padding(.top, .Spacing.xs)
        case .TopS:
            self.padding(.top, .Spacing.s)
        case .TopM:
            self.padding(.top, .Spacing.m)
        case .TopL:
            self.padding(.top, .Spacing.l)
        case .TopXL:
            self.padding(.top, .Spacing.xl)
        case .BottomXS:
            self.padding(.top, .Spacing.xs)
        case .BottomS:
            self.padding(.top, .Spacing.xs)
        case .BottomM:
            self.padding(.top, .Spacing.xs)
        case .BottomL:
            self.padding(.top, .Spacing.xs)
        case .BottomXL:
            self.padding(.top, .Spacing.xs)
        case .LeadingXS:
            self.padding(.top, .Spacing.xs)
        case .LeadingS:
            self.padding(.top, .Spacing.xs)
        case .LeadingM:
            self.padding(.top, .Spacing.xs)
        case .LeadingL:
            self.padding(.top, .Spacing.xs)
        case .LeadingXL:
            self.padding(.top, .Spacing.xs)
        case .TrailingXS:
            self.padding(.top, .Spacing.xs)
        case .TrailingS:
            self.padding(.top, .Spacing.xs)
        case .TrailingM:
            self.padding(.top, .Spacing.xs)
        case .TrailingL:
            self.padding(.top, .Spacing.xs)
        case .TrailingXL:
            self.padding(.top, .Spacing.xs)
        case .VerticalXS:
            self.padding(.top, .Spacing.xs)
        case .VerticalS:
            self.padding(.top, .Spacing.xs)
        case .VerticalM:
            self.padding(.top, .Spacing.xs)
        case .VerticalL:
            self.padding(.top, .Spacing.xs)
        case .VerticalXL:
            self.padding(.top, .Spacing.xs)
        case .HorizontalXS:
            self.padding(.top, .Spacing.xs)
        case .HorizontalS:
            self.padding(.top, .Spacing.xs)
        case .HorizontalM:
            self.padding(.top, .Spacing.xs)
        case .HorizontalL:
            self.padding(.top, .Spacing.xs)
        case .HorizontalXL:
            self.padding(.top, .Spacing.xs)
        }
    }
}

