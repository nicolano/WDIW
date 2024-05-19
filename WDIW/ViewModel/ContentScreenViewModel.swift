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
    @Published var selectedYears: [String] = ["2024"]
    @Published var yearSelectionIsExtended: Bool = false

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
    
    var cancellable : AnyCancellable?
    func observeSortBy() {
        cancellable = self.$sortBy.sink { newValue in
            self.sortContent(sortBy: newValue)
        }
    }
    
    var cancellable2 : AnyCancellable?
    func observeShowSearch() {
        cancellable2 = self.$showSearch.sink { newValue in
            if newValue == false {
                self.searchQuery.removeAll()
            }
        }
    }
    
    var cancellable3 : AnyCancellable?
    func observeSearchquery() {
        cancellable3 = self.$searchQuery.sink { newValue in
            self.sortContent(sortBy: self.sortBy)
        }
    }
    
    var cancellable4 : AnyCancellable?
    func observeYearsWithEntry() {
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
    
    var cancellable5 : AnyCancellable?
    func observeSelectedYears() {
        cancellable5 = self.$selectedYears.sink { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                self.sortContent(sortBy: self.sortBy)
            }
        }
    }
    
    func getYearsFromContents(contents: [MediaContent]) -> [String] {
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
    
    func selectYear(year: String) {
        if self.selectedYears.count == 1 && self.selectedYears.first == year {
            return
        }
        
        if self.selectedYears.contains(year) {
            self.selectedYears.removeAll(where: { $0 == year })
        } else {
            self.selectedYears.append(year)
        }
        
        self.storedSelectedYears = self.selectedYears
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
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
             self.displayedContents = contents
        }
    }
    
    func toggleSearchField() {
        self.showSearch.toggle()
    }
}
