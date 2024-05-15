//
//  EditSeriesContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct EditSeriesContent: View {
    @Binding var series: Series
    
    var body: some View {
        VStack.spacingM {
            CustomTextField(value: $series.name, title: "Name")
            
            CustomTextField(value: $series.directors, title: "Director/s")
            
            CustomTextField(value: $series.additionalInfo, title: "Additional Informations", lineLimit: 5)
            
            RatingEditor(value: $series.rating, title: "Rating")
            
            CustomDateField(value: $series.date, title: "Date")
                .padding(.TopS)
        }
        .padding(.AllM)
    }
}
