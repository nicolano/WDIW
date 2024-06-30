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

    let contentCategory: ContentCategories
    
    @State var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        VStack.zeroSpacing(alignment: .leading) {
            if contentScreenVM.contents.isEmpty {
                NoContentSection(contentCategory: .movies)
            } else {
                VerticalScrollView($navigationVM.contentScrollOffset) {
                    LazyVStack(spacing: .Spacing.s) {
                        ForEach(contentScreenVM.displayedContents.indices, id: \.self) { index in
                            ContentItem(contentScreenVM.displayedContents[index]) {
                                navigationVM.openSelectedContentHero(content: contentScreenVM.displayedContents[index])
                            }                
                            .transaction { trans in
                                trans.animation = .none
                            }
                            
                            if index < contentScreenVM.displayedContents.indices.count - 1 {
                                Rectangle().fill(Color.Custom.divider).frame(height: 1)
                            }
                        }
                    }
                    .padding(.TopS)
                    .padding(.HorizontalM)
                    .safeAreaPadding(.bottom, 100)
                }
                .searchField()
                .overlay {
                    YearSelection()
                        .align(.topTrailing)
                        .padding(.TopS)
                }
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
    
