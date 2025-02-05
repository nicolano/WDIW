//
//  SeasonsEditor.swift
//  WDIW
//
//  Created by Nicolas von Trott on 05.02.25.
//

import SwiftUI
import WrappingHStack

struct SeasonsEditor: View {
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @EnvironmentObject private var contentVM: ContentViewModel

    @Binding var series: Series
    let isEditMode: Bool
    
    func getIconNameForNumber(_ number: Int, isSelected: Bool) -> String {
        if isSelected {
                return "\(number).circle.fill"
        }
        return "\(number).circle"
    }
    
    @State private var prevWatchedSeasons: [Int] = []
    
    var body: some View {
        VStack.spacingXS {
            HStack {
                Text("Seasons")
                    .bold()
                    .align(.leading)
                    .padding(.BottomXS)
                
                Spacer()
                
                if isEditMode {
                    Button {
                        withAnimation {
                            series.seasons.increaseTotalSeasons()
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundStyle(settingsVM.preferredAccentColor)
                    }
                    
                    Button {
                        withAnimation {
                            series.seasons.decreaseTotalSeasons()
                        }
                    } label: {
                        Image(systemName: "minus")
                            .font(.title)
                            .foregroundStyle(settingsVM.preferredAccentColor)
                    }
                }
            }
            
            WrappingHStack(1...series.seasons.totalSeasons, id:\.self, alignment: .leading, lineSpacing: .Spacing.s) {
                seasonButton($0)
            }
        }
        .onAppear {
            prevWatchedSeasons = contentVM.getPrevWatchedSeasonsFor(series)
            if prevWatchedSeasons.max() ?? 0 > series.seasons.totalSeasons {
                series.seasons.totalSeasons = prevWatchedSeasons.max() ?? 0
            }
        }
    }
}

extension SeasonsEditor {
    private func seasonButton(_ season: Int) -> some View {
        Button {
            if series.seasons.watchedSeasons.contains(season) {
                series.seasons.watchedSeasons.removeAll(where: { $0 == season })
            } else {
                series.seasons.watchedSeasons.append(season)
            }
        } label: {
            Image(systemName: getIconNameForNumber(season, isSelected: series.seasons.watchedSeasons.contains(season)))
            .font(.largeTitle)
            .foregroundStyle(
                (prevWatchedSeasons.contains(season) || series.seasons.watchedSeasons.contains(season))
                    ? settingsVM.preferredAccentColor : .primary
            )
            .symbolEffect(.bounce, value: series.seasons.watchedSeasons.contains(season))
        }
        .transition(.scale)
        .disabled(!isEditMode)
    }
}
