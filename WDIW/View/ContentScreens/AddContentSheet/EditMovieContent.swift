//
//  EditMovieContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct EditMovieContent: View {
    internal init(_ movie: Binding<Movie>) {
        self._movie = movie
    }
    
    @Binding var movie: Movie

    var body: some View {
        VStack.spacingM {
            CustomTextField(value: $movie.name, title: "Name")
            
            RatingEditor(value: $movie.rating, title: "Rating")

            CustomDateField(value: $movie.watchDate, title: "Date")
                .padding(.TopS)
        }
        .padding(.AllM)
    }
}

