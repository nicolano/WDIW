//
//  YearButton.swift
//  WDIW
//
//  Created by Nicolas von Trott on 26.06.24.
//

import SwiftUI

struct YearButton: View {
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @EnvironmentObject private var contentScreenVM: ContentScreenViewModel
    
    let year: String
    let extendedHeight: CGFloat
    let reducedSize: CGFloat
    let onTap: () -> Void
    
    private var isExtended: Bool {
        contentScreenVM.yearSelectionIsExtended
    }
    
    var body: some View {
        Button {
            onTap()
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
}
