//
//  ContentScreen.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct ContentScreen: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @EnvironmentObject private var contentVM: ContentViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @EnvironmentObject private var contentScreenVM: ContentScreenViewModel
    @Environment(\.keyboardShowing) var keyboardShowing

    let contentCategory: ContentCategories
    
    @State var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        VStack.zeroSpacing(alignment: .leading) {
            if contentScreenVM.contents.isEmpty {
                NoContentSection(contentCategory: contentCategory)
            } else {
                VerticalScrollView($navigationVM.contentScrollOffset) {
                    LazyVStack(spacing: .Spacing.s) {
                        ForEach(contentScreenVM.displayedContents.indices, id: \.self) { index in
                            let content = contentScreenVM.displayedContents[index]
                            let previousContent = index > 0 ? contentScreenVM.displayedContents[index - 1] : content
                            let nextContent = index < contentScreenVM.displayedContents.count - 1 ? contentScreenVM.displayedContents[index + 1] : content
                            let previousYearString = String(Calendar.current.dateComponents([.year], from: previousContent.date).year ?? 0)
                            let nextYearString = String(Calendar.current.dateComponents([.year], from: nextContent.date).year ?? 0)
                            let yearString = String(Calendar.current.dateComponents([.year], from: content.date).year ?? 0)
                            
                            if (previousYearString != yearString || index == 0) && (contentScreenVM.sortBy == .dateForward || contentScreenVM.sortBy == .dateReverse) {
                                Text(yearString)
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(settingsVM.preferredAccentColor)
                                    .align(.leading)
                                    .padding(.TopS)
                            }
                            
                            ContentItem(content) {
                                navigationVM.openSelectedContentHero(content: content)
                            }
                            .transaction { trans in
                                trans.animation = .none
                            }
                            
                            if index < contentScreenVM.displayedContents.indices.count - 1 {
                                if contentScreenVM.sortBy == .dateForward || contentScreenVM.sortBy == .dateReverse {
                                    if nextYearString == yearString  {
                                        Rectangle().fill(Color.Custom.divider).frame(height: 1)
                                    }
                                } else {
                                    Rectangle().fill(Color.Custom.divider).frame(height: 1)
                                }
                            }
                        }
                    }
                    .padding(.TopS)
                    .padding(.HorizontalM)
                    .safeAreaPadding(.bottom, keyboardShowing ? 400 : 100)
                }
                .searchField()
            }
            
            Spacer(minLength: 0)
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
    
