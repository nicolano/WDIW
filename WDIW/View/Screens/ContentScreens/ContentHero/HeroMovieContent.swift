//
//  HeroMovieContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.05.24.
//

import SwiftUI

struct HeroMovieContent: View {
    let movie: Movie
    
    var body: some View {
        VStack.zeroSpacing(alignment: .leading) {
            HStack.spacingM(alignment: .top) {
                Text(movie.name)
                    .font(.title)
                    .fontWeight(.black)
                    .align(.leading)
                
                RatingContent(rating: movie.rating)
            }
            
            Text(movie.director)
                .font(.headline)
                .padding(.BottomM)
            
            Group {
                if movie.additionalInfo.isEmpty {
                    Text("...")
                } else {
                    Text(movie.additionalInfo)
                }
            }
            
            Group {
                Text("Watched on: ") + Text(movie.date, style: .date).font(.headline)
            }
            .padding(.TopM)

            Divider()
                .padding(.VerticalM)

            VStack.spacingM {
                WikipediaContent(contentFor: movie.name)
                
                WikipediaContent(contentFor: movie.director)
                
                LinkContent(contentFor: movie.name)
                
                LinkContent(contentFor: movie.director)
            }
        }
    }
}
