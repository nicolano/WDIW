//
//  ContentScreenViewModel.swift
//  WDIW
//
//  Created by Nicolas von Trott on 18.05.24.
//

import Foundation
import Combine
import SwiftUI

enum SortBy {
    case dateForward, dateReverse, 
         nameForward, nameReverse,
         authorForward, authorReversed,
         ratingForward, ratingReversed
}

func sortByDescription(_ sortBy: SortBy) -> String {
    switch sortBy {
    case .dateForward:
        "Date, oldest first"
    case .dateReverse:
        "Date, latest first"
    case .nameForward:
        "Name ascending"
    case .nameReverse:
        "Name descending"
    case .authorForward:
        "Author ascending"
    case .authorReversed:
        "Author descending"
    case .ratingForward:
        "Rating ascending"
    case .ratingReversed:
        "Rating descending"
    }
}

@MainActor
class ContentScreenViewModels: ObservableObject {
    @Published var forBooks: ContentScreenViewModel
    @Published var forMovies: ContentScreenViewModel
    @Published var forSeries: ContentScreenViewModel
    
    init(contentVM: ContentViewModel) {
        self.forBooks = ContentScreenViewModel(
            contentVM: contentVM,
            contentCategory: .books
        )
        self.forMovies = ContentScreenViewModel(
            contentVM: contentVM,
            contentCategory: .movies
        )
        self.forSeries = ContentScreenViewModel(
            contentVM: contentVM,
            contentCategory: .series
        )
    }
}

@MainActor
class ContentScreenViewModel: ObservableObject {
    internal init(contentVM: ContentViewModel, contentCategory: ContentCategories) {
        self.contentVM = contentVM
        self.contentCategory = contentCategory
        
        observeShowSearch()
        observeSearchquery()
        observeSortBy()
        observeYearsWithEntry()
        observeSelectedYears()
        observeImportsAndDeletions()
        
        selectedYears = storedSelectedYears
    }
    
    let contentVM: ContentViewModel
    let contentCategory: ContentCategories
    
    @Published var showSearch: Bool = false
    @Published var searchQuery: String = ""
    @Published var sortBy: SortBy = .dateReverse
    @Published var displayedContents: [MediaContent] = []
    
    @Published var yearsWithEntry: [String] = []
    @AppStorage("selectedYears") var storedSelectedYears: [String] = []
    @Published var selectedYears: [String] = ["2025"]
    @Published var selectedYearsCache: [String] = []

    @Published var yearSelectionIsExtended: Bool = false

    @Published var isSearchFieldFocused: Bool = false
    
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
    
    private var contentsFiltered: [MediaContent] {
        let contetsFilteredForYear = contents.filter {
            let components = Calendar.current.dateComponents([Calendar.Component.year], from: $0.date)
            let year = components.year?.description ?? ""
            
            return self.selectedYears.contains(year)
        }
        
        if searchQuery.isEmpty {
            return contetsFilteredForYear
        } else {
            return contetsFilteredForYear.filter { content in
                content.name.localizedCaseInsensitiveContains(searchQuery) ||
                content.creator.localizedCaseInsensitiveContains(searchQuery) ||
                content.additionalInfo.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
    
    private var cancellable : AnyCancellable?
    private func observeSortBy() {
        cancellable = self.$sortBy.sink { newValue in
            self.sortContent(sortBy: newValue)
        }
    }
    
    private var cancellable2 : AnyCancellable?
    private func observeShowSearch() {
        cancellable2 = self.$showSearch.sink { newValue in
            if newValue == false {
                self.searchQuery.removeAll()
                self.selectedYears = self.selectedYearsCache
            } else {
                self.selectedYearsCache = self.selectedYears
                self.selectAllYears()
            }
        }
    }
    
    private var cancellable3 : AnyCancellable?
    private func observeSearchquery() {
        cancellable3 = self.$searchQuery.sink { newValue in
            self.refresh()
        }
    }
    
    private var cancellable4 : AnyCancellable?
    private func observeYearsWithEntry() {
        switch contentCategory {
        case .books:
            cancellable4 = contentVM.$books.sink { contents in
                self.yearsWithEntry = self.getYearsFromContents(contents: contents)
            }
        case .movies:
            cancellable4 = contentVM.$movies.sink { contents in
                self.yearsWithEntry = self.getYearsFromContents(contents: contents)
            }
        case .series:
            cancellable4 = contentVM.$series.sink { contents in
                self.yearsWithEntry = self.getYearsFromContents(contents: contents)
            }
        }
    }
    
    private var cancellable5 : AnyCancellable?
    private func observeSelectedYears() {
        cancellable5 = self.$selectedYears.sink { newValue in
            self.refresh()
        }
    }
    
    private var cancellable6 : AnyCancellable?
    private func observeImportsAndDeletions() {
        cancellable6 = self.contentVM.$hasImportedOrDeleted.sink { newValue in
            if newValue == true {
                self.selectAllYears()
                self.refresh()
            }
        }
    }
    
    private func getYearsFromContents(contents: [MediaContent]) -> [String] {
        var years: [String] = []
        for content in contents {
            let components = Calendar.current.dateComponents([Calendar.Component.year], from: content.date)
            let year = components.year?.description ?? ""
            
            if !years.contains(year) {
                years.append(year)
            }
        }
        
        return years
    }
    
    func selectAllYears() {
        self.selectedYears = self.yearsWithEntry
        self.storedSelectedYears = self.selectedYears
    }
    
    func selectCurrentYear() {
        if !self.yearsWithEntry.isEmpty {
            self.selectedYears.removeAll()
            self.selectedYears.append(self.yearsWithEntry.first!)
            self.storedSelectedYears = self.selectedYears
        }
    }
    
    func selectYear(year: String) {
        if self.selectedYears.count == 1 && self.selectedYears.first == year {
            return
        }
        
        if self.selectedYears.contains(year) {
            self.selectedYears.removeAll(where: { $0 == year })
        } else {
            self.selectedYears.append(year)
            self.selectedYears.sort(by: >)
        }
        
        self.storedSelectedYears = self.selectedYears
    }
        
    private func sortContent(sortBy: SortBy) {
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
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.creator, order: .forward))
        case .authorReversed:
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.creator, order: .reverse))
        case .ratingForward:
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.rating, order: .forward))
        case .ratingReversed:
            sortedContent = contentsFiltered.sorted(using: SortDescriptor(\.rating, order: .reverse))
        }
        fillDisplayedContens(contents: sortedContent)
    }
    
    private func fillDisplayedContens(contents: [MediaContent]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
             self.displayedContents = contents
        }
    }
    
    func toggleSearchField() {
        if self.showSearch {
            self.clearSearchQuery()
            self.isSearchFieldFocused = false
        } else {
            self.isSearchFieldFocused = true
        }
        
        if self.showSearch {
            self.clearSearchQuery()
        }
        
        self.showSearch.toggle()
    }
    
    func clearSearchQuery() {
        self.searchQuery.removeAll()
        refresh()
    }
    
    private func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.sortContent(sortBy: self.sortBy)
        }
    }
    
    func addContent(content: MediaContent) {
        contentVM.addContent(content: content)
        refresh()
    }
    
    func deleteContent(content: MediaContent) {
        contentVM.deleteContent(content: content)
        refresh()
    }
}
