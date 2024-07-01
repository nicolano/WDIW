//
//  EditSeriesContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

fileprivate enum FocusedField {
    case name, director, additionalInfo
}

struct EditSeriesContent: View {
    @EnvironmentObject private var contentVM: ContentViewModel

    @Binding var series: Series
    @FocusState private var focusedField: FocusedField?
    @State var predictions: [String] = []
    
    var nonFocused: Bool { return self.focusedField == nil }
    
    var body: some View {
        VStack.spacingM {
            if focusedField == .name || nonFocused {
                CustomTextField(value: $series.name, title: "Name")
                    .focused($focusedField, equals: .name)
            }
            
            if focusedField == .director || nonFocused {
                CustomTextField(value: $series.directors, title: "Director/s")
                    .focused($focusedField, equals: .director)
            }
            
            
            if focusedField == .additionalInfo || nonFocused {
                CustomTextField(value: $series.additionalInfo, title: "Additional Informations", lineLimit: 5)
                    .focused($focusedField, equals: .additionalInfo)
            }
            
            if focusedField == .name {
                PredictionsLists(predictions: predictions) { index in
                    series.name = predictions[index]
                    focusedField = nil
                }
            }
            
            if nonFocused {
                RatingEditor(value: $series.rating, title: "Rating")
                
                CustomDateField(value: $series.date, title: "Date")
                    .padding(.TopS)
            }
        }
        .padding(.AllM)
        .animation(.smooth, value: focusedField)
        .onChange(of: series.name) { _, newValue in
            predictions = contentVM.series
                .map({$0.name})
                .filter { names in
                    names.localizedCaseInsensitiveContains(series.name)
                }
                .uniqued()
        }
    }
}
