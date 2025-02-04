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
            Group {
                Text("\(rating)")
                    .foregroundStyle(Color.yellow)
                + Text("/10")
            }
            .bold()
            .padding(.AllXS)
            .background(Color.Custom.surface)
            .clipShape(RoundedRectangle(cornerRadius: .CornerRadius.textField))
        }
    }
}
