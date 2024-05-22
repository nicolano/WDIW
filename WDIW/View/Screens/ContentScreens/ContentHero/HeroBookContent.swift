//
//  HeroBookContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 22.05.24.
//

import SwiftUI

struct HeroBookContent: View {
    let book: Book
    
    var body: some View {
        VStack.zeroSpacing(alignment: .leading) {
            HStack.spacingM(alignment: .top) {
                Text(book.name)
                    .font(.title)
                    .fontWeight(.black)
                    .align(.leading)
                
                if book.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .padding(.top, 7)
                }
            }
            
            
            Text(book.creator)
                .font(.headline)
                .padding(.BottomM)
            
            Group {
                if book.additionalInfo.isEmpty {
                    Text("...")
                } else {
                    Text(book.additionalInfo)
                }
            }

            Divider()
                .padding(.VerticalM)

            WikipediaContent(contentFor: book.author)
        }
    }
}

