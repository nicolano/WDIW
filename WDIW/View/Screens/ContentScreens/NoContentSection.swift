//
//  NoContentSection.swift
//  WDIW
//
//  Created by Nicolas von Trott on 21.02.24.
//

import SwiftUI

struct NoContentSection: View {
    let contentCategory: ContentCategories
    
    var body: some View {
        Group {
            Image("NoContent")
                .resizable()
                .scaledToFit()
                .frame(width: 2 * UIScreen.main.bounds.width / 3)
                .padding(.bottom, .Spacing.m)
            
            Group {
                Text("You haven't saved any ")
                +
                Text(contentCategory.getName())
                +
                Text(" yet.")
            }
            .align(.hCenter)
        }
        .align(.vCenter)
    }
}

#Preview {
    NoContentSection(contentCategory: .books)
}
