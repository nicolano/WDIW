//
//  EditSeriesContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct EditSeriesContent: View {
    internal init(_ series: Binding<Series>) {
        self._series = series
    }
    
    @Binding var series: Series
    
    var body: some View {
        VStack.spacingM {
            CustomTextField(value: $series.name, title: "Name")
            
            CustomTextField(value: $series.additionalInfos, title: "Additional Informations")
            
            RatingEditor(value: $series.rating, title: "Rating")
            
            CustomDateField(value: $series.entryDate, title: "Date")
                .padding(.TopS)
        }
        .padding(.AllM)
    }
}
