//
//  HeroSeriesContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.05.24.
//

import SwiftUI

struct HeroSeriesContent: View {
    let series: Series
    
    var body: some View {
        VStack.zeroSpacing(alignment: .leading) {
            HStack.spacingM(alignment: .top) {
                Text(series.name)
                    .font(.title)
                    .fontWeight(.black)
                    .align(.leading)
                
                RatingContent(rating: series.rating)
            }
            
            Group {
                if series.additionalInfo.isEmpty {
                    Text("...")
                } else {
                    Text(series.additionalInfo)
                }
            }
            
            Group {
                Text("Entered on: ") + Text(series.date, style: .date).font(.headline)
            }
            .padding(.TopM)

            Divider()
                .padding(.VerticalM)

            VStack.spacingM {
                IMDbContent(contentFor: series.name)
                
//                WikipediaContent(contentFor: series.name)
                                
                LinkContent(contentFor: series.name)
            }
        }
    }
}
