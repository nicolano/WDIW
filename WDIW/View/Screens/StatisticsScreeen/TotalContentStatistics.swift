//
//  TotalContentStatistics.swift
//  WDIW
//
//  Created by Nicolas von Trott on 31.01.25.
//

import SwiftUI

struct TotalContentStatistics: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var statisticsVM: StatisticsViewModel

    var body: some View {
        ScrollView(.horizontal) {
            HStack.spacingS {
                totalCategoryStats(category: .books, count: statisticsVM.totalStatistics.booksCount)
                totalCategoryStats(category: .movies, count: statisticsVM.totalStatistics.moviesCount)
                totalCategoryStats(category: .series, count: statisticsVM.totalStatistics.seriesCount)
            }
        }
        .scrollIndicators(.hidden)
    }
}

extension TotalContentStatistics {
    private func totalCategoryStats(category: ContentCategories, count: Int) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: category.getIconName(isActive: true))
                
                Text("\(count)").font(.largeTitle).bold()
            }
            
            Text(category.getName())
        }
        .padding(.AllM)
    }
}
