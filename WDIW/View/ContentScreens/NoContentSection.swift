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
        VStack {
            Spacer()
            
            Image("NoContent")
                .resizable()
                .scaledToFit()
                .frame(width: 2 * UIScreen.main.bounds.width / 3)
                .padding(.bottom, .Spacing.m)
            
            HStack {
                Spacer()
                
                Text("You haven't saved any ")
                +
                Text(contentCategory.getName())
                +
                Text(" yet.")
                
                Spacer()
            }
            
            Spacer()
        }
    }
}

#Preview {
    NoContentSection(contentCategory: .books)
}
