//
//  SeriesEditor.swift
//  WDIW
//
//  Created by Nicolas von Trott on 04.02.25.
//

import SwiftUI
import WrappingHStack

struct SeasonsEditor: View {
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    let totalSeasons: Int
    let prevWatchedSeasons: [Int]
    
    func getIconNameForNumber(_ number: Int, isSelected: Bool) -> String {
        if isSelected {
                return "\(number).circle.fill"
        }
        return "\(number).circle"
    }
    
    @State private var selectedSeasons: [Int] = []
    
    var body: some View {
        VStack.spacingXS {
            Text("Seasons")
                .bold()
                .align(.leading)
                .padding(.BottomXS)
            
            WrappingHStack(1...totalSeasons, id:\.self, alignment: .leading, lineSpacing: .Spacing.s) {
                seasonButton($0)
            }
        }
    }
}

extension SeasonsEditor {
    private func seasonButton(_ season: Int) -> some View {
        Button {
            if selectedSeasons.contains(season) {
                selectedSeasons.removeAll(where: { $0 == season })
            } else {
                selectedSeasons.append(season)
            }
        } label: {
            Image(systemName: getIconNameForNumber(season, isSelected: selectedSeasons.contains(season)))
            .font(.largeTitle)
            .foregroundStyle(
                (prevWatchedSeasons.contains(season) || selectedSeasons.contains(season))
                    ? settingsVM.preferredAccentColor : .primary
            )
            .symbolEffect(.bounce, value: selectedSeasons.contains(season))
        }
    }
}
