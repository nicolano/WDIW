//
//  ContentScreenViewModel.swift
//  WDIW
//
//  Created by Nicolas von Trott on 18.05.24.
//

import Foundation
import Combine

enum SortBy {
    case dateForward, dateReverse, 
         nameForward, nameReverse,
         authorForward, authorReversed,
         ratingForward, ratingReversed
}

@MainActor
class ContentScreenViewModel: ObservableObject {
    internal init(contentVM: ContentViewModel, contentCategory: ContentCategories) {
        self.contentVM = contentVM
        self.contentCategory = contentCategory
        
        observeSortBy()
    }
    
    let contentVM: ContentViewModel
    let contentCategory: ContentCategories
    
    @Published var showSearch: Bool = false
    @Published var searchQuery: String = ""
    @Published var sortBy: SortBy = .dateReverse
    @Published var displayedContents: [MediaContent] = []
    
    var contents: [MediaContent] {
        switch contentCategory {
        case .books:
            return contentVM.books
        case .movies:
            return contentVM.movies
        case .series:
            return contentVM.series
        }
    }
    
    var contentsFiltered: [MediaContent] {
        if searchQuery.isEmpty {
            contents
        } else {
            contents.filter { content in
                content.name.localizedCaseInsensitiveContains(searchQuery) ||
                content.creator.localizedCaseInsensitiveContains(searchQuery) ||
                content.additionalInfo.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
    
    var cancellable : AnyCancellable?
    func observeSortBy() {
        cancellable = self.$sortBy.sink { newValue in
            self.sortContent(sortBy: newValue)
        }
    }
    
    func sortContent(sortBy: SortBy) {
        var sortedContent: [MediaContent] = []
        switch sortBy {
        case .dateForward:
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.date, order: .forward))
        case .dateReverse:
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.date, order: .reverse))
        case .nameForward:
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.name, order: .forward))
        case .nameReverse:
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.name, order: .reverse))
        case .authorForward:
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.additionalInfo, order: .forward))
        case .authorReversed:
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.additionalInfo, order: .reverse))
        case .ratingForward:
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.rating, order: .forward))
        case .ratingReversed:
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.rating, order: .reverse))
        }
        fillDisplayedContens(contents: sortedContent)
    }
    
    func fillDisplayedContens(contents: [MediaContent]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
             self.displayedContents = contents
        }
    }
}
