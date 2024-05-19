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
            ContentScreenHeader(contentCategory: contentCategory)
            
            if contentScreenVM.contents.isEmpty {
                NoContentSection(contentCategory: .movies)
            } else {
                ScrollView {
                    LazyVStack(spacing: .Spacing.s) {
                        ForEach(contentScreenVM.displayedContents.indices, id: \.self) { index in
                            ContentItem(contentScreenVM.displayedContents[index]) {
                                navigationVM.openEditContentSheet(content: contentScreenVM.displayedContents[index])
                            }
                            .transaction { trans in
                                trans.animation = .none
                            }
                        }
                    }
                    .padding(contentScreenVM.yearSelectionIsExtended ? .TopXL : .TopL)
                    .padding(.HorizontalM)
                    .background {
                        GeometryReader {
                            Color.clear.preference(
                                key: ViewOffsetKey.self,
                                value: -$0.frame(in: .named("scroll")).origin.y
                            )
                        }
                    }
                    .listStyle(.plain)
                    .safeAreaPadding(.bottom, 100)
                    .searchField(
                        searchQuery: $contentScreenVM.searchQuery,
                        showSearch: contentScreenVM.showSearch
                    )
                }
                .onPreferenceChange(ViewOffsetKey.self) {
                   scrollViewOffset = $0
                }
                .coordinateSpace(name: "scroll")
                .overlay {
                    YearSelection(scrollViewOffset: scrollViewOffset)
                        .align(.topLeading)
                        .padding(.top, contentScreenVM.showSearch ? 52 : 0)
                }
            }
            
            Spacer()
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
    
