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

    private let reducedSize: CGFloat = 10
    private let extendedHeight: CGFloat = 30
    
    private var isExtended: Bool {
        contentScreenVM.yearSelectionIsExtended
    }
    
    var body: some View {
        VStack.spacingXS {
            ForEach(contentScreenVM.yearsWithEntry, id: \.self) { year in
                YearButton(year: year, extendedHeight: extendedHeight, reducedSize: reducedSize) {
                    contentScreenVM.selectYear(year: year)
                }
            }
            
            backButton
        }
        .padding(.horizontal, isExtended ? .Spacing.m : .Spacing.s)
        .padding(isExtended ? .VerticalM : .VerticalS)
        .background(background)
        .opacity(contentScreenVM.yearsWithEntry.count > 1 ? 1 : 0)
        .offset(x: contentScreenVM.showSearch ? reducedSize + 2 * .Spacing.s : 0)
    }
}

extension YearSelection {
    private var background: some View {
        Rectangle()
            .fill(Material.ultraThin)
            .onTapGesture {
                withAnimation {
                    contentScreenVM.yearSelectionIsExtended.toggle()
                }
            }
            .clipShape(
                .rect(
                    topLeadingRadius: .CornerRadius.contentItem,
                    bottomLeadingRadius: .CornerRadius.contentItem,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 0
                )
            )
            .shadow(radius: 10)
    }
    
    private var backButton: some View {
        Button {
            withAnimation {
                contentScreenVM.yearSelectionIsExtended = false
            }
        } label: {
            Image(systemName: "arrowshape.forward.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .padding(.AllS)
                .frame(
                    width: isExtended ? extendedHeight * 2 : 0,
                    height: isExtended ? extendedHeight : 0
                )
                .background {
                    RoundedRectangle(
                        cornerRadius: isExtended ? extendedHeight / 3 : reducedSize / 2
                    )
                    .fill(settingsVM.preferredAccentColor)
                }
        }
        .padding(.top, isExtended ? .Spacing.m : 0)
    }
}
