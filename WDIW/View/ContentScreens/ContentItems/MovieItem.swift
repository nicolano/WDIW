//
//  MovieItem.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct MovieItem: View {
    internal init(_ movie: Movie, onTap: @escaping () -> Void) {
        self.movie = movie
        self.onTap = onTap
    }
    
    private let movie: Movie
    private let onTap: () -> Void
    
    var body: some View {
        HStack.spacingS(alignment: .top) {
            VStack.spacingXS(alignment: .leading) {
                Text(movie.name)
                    .bold()
                
                Text(movie.watchDate, style: .date)
            }
            .multilineTextAlignment(.leading)
            .foregroundStyle(Color.primary)

            Spacer(minLength: 0)
            
            Group {
                Text("\(Int(movie.rating))") + Text("/10")
            }
            .foregroundStyle(Color.yellow)
        }
    }
}
