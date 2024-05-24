//
//  SeriesItem.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct SeriesItem: View {
    internal init(_ series: Series, onTap: @escaping () -> Void) {
        self.series = series
        self.onTap = onTap
    }
    
    private let series: Series
    private let onTap: () -> Void
    
    var body: some View {
        HStack.spacingS(alignment: .top) {
            VStack.spacingXS(alignment: .leading) {
                Text(series.name)
                    .bold()
                
                Text(series.additionalInfo)
            }
            .multilineTextAlignment(.leading)
            .foregroundStyle(Color.primary)

            Spacer(minLength: 0)
            
            RatingContent(rating: series.rating)
        }
    }
}
