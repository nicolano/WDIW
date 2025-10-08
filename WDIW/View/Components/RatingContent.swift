//
//  RatingContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.05.24.
//

import SwiftUI

struct RatingContent: View {
    let rating: Int
    
    var body: some View {
        VStack {
            Text({
                var a = AttributedString("\(rating)/10")
                if let range = a.range(of: String(rating)) {
                    a[range].foregroundColor = .yellow
                }
                return a
            }())
            .bold()
            .padding(.AllXS)
            .background(Color.Custom.surface)
            .clipShape(RoundedRectangle(cornerRadius: .CornerRadius.textField))
        }
    }
}
