//
//  EditMovieContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct EditMovieContent: View {
    @Binding var movie: Movie

    var body: some View {
        VStack.spacingM {
            CustomTextField(value: $movie.name, title: "Name")
            
            CustomTextField(value: $movie.additionalInfo, title: "Additional Informations")

            RatingEditor(value: $movie.rating, title: "Rating")

            CustomDateField(value: $movie.date, title: "Date")
                .padding(.TopS)
        }
        .padding(.AllM)
    }
}

