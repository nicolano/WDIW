//
//  EditMovieContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

fileprivate enum FocusedField {
    case name, director, additionalInfo
}

struct EditMovieContent: View {
    @EnvironmentObject private var contentVM: ContentViewModel
    
    @Binding var movie: Movie

    @FocusState private var focusedField: FocusedField?
    
    @State var directorPredictions: [String] = []
    @State var moviePredictions: [Movie] = []
    
    var nonFocused: Bool { return self.focusedField == nil }
    
    var body: some View {
        VStack.spacingM {
            if focusedField == .name || nonFocused {
                CustomTextField(value: $movie.name, title: "Name")
                    .focused($focusedField, equals: .name)
            }
            
            if focusedField == .director || nonFocused {
                CustomTextField(value: $movie.director, title: "Director")
                    .focused($focusedField, equals: .director)
            }
            
            if focusedField == .additionalInfo || nonFocused {
                CustomTextField(value: $movie.additionalInfo, title: "Additional Informations", lineLimit: 5)
                    .focused($focusedField, equals: .additionalInfo)
            }
            
            if focusedField == .name {
                PredictionsLists(predictions: moviePredictions.map({$0.name})) { index in
                    let predictedMovie = moviePredictions[index]
                    movie.name = predictedMovie.name
                    movie.director = predictedMovie.director
                    movie.rating = predictedMovie.rating
                    movie.additionalInfo = predictedMovie.additionalInfo
                    
                    focusedField = nil
                }
            }
            
            if focusedField == .director {
                PredictionsLists(predictions: directorPredictions) { index in
                    movie.director = directorPredictions[index]
                    focusedField = nil
                }
            }

            if nonFocused {
                RatingEditor(value: $movie.rating, title: "Rating")

                CustomDateField(value: $movie.date, title: "Date")
                    .padding(.TopS)
            }
        }
        .padding(.AllM)        
        .animation(.smooth, value: focusedField)
        .onChange(of: movie.director) { _, newValue in
            directorPredictions = contentVM.movies
                .map({$0.director})
                .filter { names in
                    names.localizedCaseInsensitiveContains(movie.director)
                }
                .uniqued()
        }
        .onChange(of: movie.name) { _, newValue in
            moviePredictions = contentVM.movies
                .filter { movies in
                    movies.name.localizedCaseInsensitiveContains(movie.name)
                }
                .uniqued()
        }
    }
}

