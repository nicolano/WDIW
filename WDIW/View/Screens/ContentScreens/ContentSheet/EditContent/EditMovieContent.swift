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
    
    @State var predictions: [String] = []
    
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
            
            if focusedField == .director {
                PredictionsLists(predictions: predictions) { index in
                    movie.director = predictions[index]
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
            predictions = contentVM.movies
                .map({$0.director})
                .filter { names in
                    names.localizedCaseInsensitiveContains(movie.director)
                }
                .uniqued()
        }
    }
}

