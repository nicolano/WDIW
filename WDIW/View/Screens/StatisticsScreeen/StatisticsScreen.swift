//
//  StatisticsScreen.swift
//  WDIW
//
//  Created by Nicolas von Trott on 31.01.25.
//

import SwiftUI

struct StatisticsScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var statisticsVM: StatisticsViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                TotalContentStatistics()
                
                Divider()
                    .padding(.HorizontalM)
                
                ForEach(Array(statisticsVM.yearStatistics.keys).sorted(by: >), id: \.self) { year in
                    let stats = statisticsVM.yearStatistics[year]
                    HStack.zeroSpacing {
                        Text(year).font(.title).bold()
                        Spacer()
                        
                        Image(systemName: ContentCategories.books.getIconName(isActive: false))
                            .padding(.TrailingXS)
                        Text("\(stats?.booksCount ?? 0)")
                            .font(.title2)
                            .padding(.TrailingM)
                        
                        Image(systemName: ContentCategories.movies.getIconName(isActive: false))
                            .padding(.TrailingXS)
                        Text("\(stats?.moviesCount ?? 0)")
                            .font(.title2)
                            .padding(.TrailingM)

                        Image(systemName: ContentCategories.series.getIconName(isActive: false))
                            .padding(.TrailingXS)
                        Text("\(stats?.seriesCount ?? 0)")
                            .font(.title2)
                    }
                    .font(.headline)
                    .padding(.TopS)
                }
                .padding(.HorizontalM)
            }
            
            Spacer()
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color(uiColor: .systemBackground))
    }
}

