//
//  Text.swift
//  WDIW
//
//  Created by Nicolas von Trott on 29.02.24.
//

import Foundation
import SwiftUI

extension HStack {
static func spacingXS(
    alignment: VerticalAlignment = .center,
    @ViewBuilder content: () -> Content
) -> HStack {
        HStack(alignment: alignment, spacing: .Spacing.xs, content: content)
    }
    
    static func spacingS(
        alignment: VerticalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> HStack {
        HStack(alignment: alignment, spacing: .Spacing.s, content: content)
    }
    
    static func spacingM(
        alignment: VerticalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> HStack {
        HStack(alignment: alignment, spacing: .Spacing.m, content: content)
    }
    
    static func spacingL(
        alignment: VerticalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> HStack {
        HStack(alignment: alignment, spacing: .Spacing.l, content: content)
    }
    
    static func spacingXL(
        alignment: VerticalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> HStack {
        HStack(alignment: alignment, spacing: .Spacing.xl, content: content)
    }
    
    static func zeroSpacing(
        alignment: VerticalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> HStack {
        HStack(alignment: alignment, spacing: 0, content: content)
    }
}

extension VStack {
    static func spacingXS(
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> VStack {
        VStack(alignment: alignment, spacing: .Spacing.xs, content: content)
    }
    
    static func spacingS(
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> VStack {
        VStack(alignment: alignment, spacing: .Spacing.s, content: content)
    }
    
    static func spacingM(
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> VStack {
        VStack(alignment: alignment, spacing: .Spacing.m, content: content)
    }
    
    static func spacingL(
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> VStack {
        VStack(alignment: alignment, spacing: .Spacing.l, content: content)
    }
    
    static func spacingXL(
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) -> VStack {
        VStack(alignment: alignment, spacing: .Spacing.xl, content: content)
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
         HorizontalXS, HorizontalS, HorizontalM, HorizontalL, HorizontalXL,
         AllXS, AllS, AllM, AllL, AllXL
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
            self.padding(.bottom, .Spacing.xs)
        case .BottomS:
            self.padding(.bottom, .Spacing.s)
        case .BottomM:
            self.padding(.bottom, .Spacing.m)
        case .BottomL:
            self.padding(.bottom, .Spacing.l)
        case .BottomXL:
            self.padding(.bottom, .Spacing.xl)
        case .LeadingXS:
            self.padding(.leading, .Spacing.xs)
        case .LeadingS:
            self.padding(.leading, .Spacing.s)
        case .LeadingM:
            self.padding(.leading, .Spacing.m)
        case .LeadingL:
            self.padding(.leading, .Spacing.l)
        case .LeadingXL:
            self.padding(.leading, .Spacing.xl)
        case .TrailingXS:
            self.padding(.trailing, .Spacing.xs)
        case .TrailingS:
            self.padding(.trailing, .Spacing.s)
        case .TrailingM:
            self.padding(.trailing, .Spacing.m)
        case .TrailingL:
            self.padding(.trailing, .Spacing.l)
        case .TrailingXL:
            self.padding(.trailing, .Spacing.xl)
        case .VerticalXS:
            self.padding(.vertical, .Spacing.xs)
        case .VerticalS:
            self.padding(.vertical, .Spacing.s)
        case .VerticalM:
            self.padding(.vertical, .Spacing.m)
        case .VerticalL:
            self.padding(.vertical, .Spacing.l)
        case .VerticalXL:
            self.padding(.vertical, .Spacing.xl)
        case .HorizontalXS:
            self.padding(.horizontal, .Spacing.xs)
        case .HorizontalS:
            self.padding(.horizontal, .Spacing.s)
        case .HorizontalM:
            self.padding(.horizontal, .Spacing.m)
        case .HorizontalL:
            self.padding(.horizontal, .Spacing.l)
        case .HorizontalXL:
            self.padding(.horizontal, .Spacing.xl)
        case .AllXS:
            self.padding(.all, .Spacing.xs)
        case .AllS:
            self.padding(.all, .Spacing.s)
        case .AllM:
            self.padding(.all, .Spacing.m)
        case .AllL:
            self.padding(.all, .Spacing.l)
        case .AllXL:
            self.padding(.all, .Spacing.xl)
        }
    }
}

