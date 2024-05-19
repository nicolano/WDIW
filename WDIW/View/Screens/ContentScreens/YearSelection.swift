//
//  YearSelection.swift
//  WDIW
//
//  Created by Nicolas von Trott on 19.05.24.
//

import SwiftUI

struct YearSelection: View {
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @EnvironmentObject private var contentScreenVM: ContentScreenViewModel

    let scrollViewOffset: CGFloat
    private let reducedSize: CGFloat = 10
    private let extendedHeight: CGFloat = 30
    
    private var isExtended: Bool {
        contentScreenVM.yearSelectionIsExtended
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack.spacingXS {
                ForEach(contentScreenVM.yearsWithEntry, id: \.self) { year in
                    Button {
                        contentScreenVM.selectYear(year: year)
                    } label: {
                        RoundedRectangle(
                            cornerRadius: isExtended ? extendedHeight / 3 : reducedSize / 2
                        )
                        .fill(
                            contentScreenVM.selectedYears.contains(year) ?
                                settingsVM.preferredAccentColor :
                                Color.clear
                        )
                        .frame(
                            width: isExtended ? extendedHeight * 2 : reducedSize,
                            height: isExtended ? extendedHeight : reducedSize
                        )
                        .overlay {
                            Text(isExtended  ? year : " ")
                                .foregroundStyle(contentScreenVM.selectedYears.contains(year) ? Color.white : Color.secondary)
                                .align(.center)
                                .scaleEffect(isExtended ? 1 : 0)
                        }
                        .background {
                            RoundedRectangle(
                                cornerRadius: isExtended ? extendedHeight / 3 : reducedSize / 2
                            )
                            .strokeBorder(
                                contentScreenVM.selectedYears.contains(year) ?
                                    settingsVM.preferredAccentColor :
                                    Color.secondary, 
                                lineWidth: 2
                            )
                        }
                    }
                }
                .padding(.TopM)
            }                
            .padding(.LeadingM)
        }
        .onChange(of: scrollViewOffset) { _, scrollViewOffset in
            if scrollViewOffset < -50 {
                withAnimation(.smooth) {
                    contentScreenVM.yearSelectionIsExtended = true
                }
            } else if scrollViewOffset > 50 {
                withAnimation(.smooth) {
                    contentScreenVM.yearSelectionIsExtended = false
                }
            }
        }
    }
}
