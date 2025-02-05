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
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    @Binding var series: ContentEntry
    @FocusState private var focusedField: FocusedField?
    @State var predictions: [String] = []

    var nonFocused: Bool { return self.focusedField == nil }
    
    let omdbFetcher = OmdbFetcher()
    
    var linkedWithImdb: Bool { !series.url.isEmpty }
    
    var body: some View {
        VStack.spacingM {
            if focusedField == .name || nonFocused {
                CustomTextField(value: $series.name, title: "Name", autoFocus: series.name.isEmpty)
                    .focused($focusedField, equals: .name)
            }
            
            
            
            if nonFocused {
                SeasonsEditor(totalSeasons: 12, prevWatchedSeasons: [1,2])
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
