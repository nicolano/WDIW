//
//  ConentViewModel.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation
import SwiftData
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    var modelContext: ModelContext
    
    @Published var contentEntries = [ContentEntry]()
    @Published var movies = [ContentEntry]()
    @Published var books = [ContentEntry]()
    @Published var series = [ContentEntry]()
    
    @Published var infoMessage: String? = nil
    private func showInfoMessage(_ text: String) async {
        infoMessage = text
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        infoMessage = nil
    }
    
    @Published var errorMessage: String? = nil
    private func showErrorMessage(_ text: String) async {
        errorMessage = text
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        errorMessage = nil
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func updateContentEntries() {
        contentEntries = fetchContentEntries()
        books = contentEntries.filter({$0.content?.contentCategory == .books})
        movies = contentEntries.filter({$0.content?.contentCategory == .movies})
        series = contentEntries.filter({$0.content?.contentCategory == .series})
    }
    
    func fetchContents() -> [ContentMedia] {
        let descriptor = FetchDescriptor<ContentMedia>(
            sortBy: [SortDescriptor(\.name, order: .reverse)]
        )
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Fetch for creators failed.")
        }
        
        return []
    }
    
    func fetchContentEntries() -> [ContentEntry] {
        let descriptor = FetchDescriptor<ContentEntry>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Fetch for creators failed.")
        }
        
        return []
    }
    
    func fetchCreators() -> [Creator] {
        let descriptor = FetchDescriptor<Creator>(
            sortBy: [SortDescriptor(\.name, order: .reverse)]
        )
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Fetch for creators failed.")
        }
        
        return []
    }
    
    func importContents(contents: [MediaContent]) async {
//        var counterNewData: Int = 0
//        var counterAlreadyInData: Int = 0
//        for content in contents {
//            if !mediaContents.map({$0.id}).contains(content.id) {
//                addContent(content: content)
//                counterNewData += 1
//            } else {
//                counterAlreadyInData += 1
//            }
//        }
//        
//        var infoText = ""
//        
//        switch contents.count {
//        case 0:
//            await showErrorMessage("We did not find any content in your file.")
//            return
//        case 1:
//            infoText += "We found **\(contents.count)** content in your file.\n\n"
//        default:
//            infoText += "We found **\(contents.count)** contents in your file.\n\n"
//        }
//                
//        switch counterAlreadyInData {
//        case 0:
//            infoText += "None of them are stored in your app.\n\n"
//        case 1:
//            infoText += "**\(counterAlreadyInData)** of these contents is already stored in your app.\n\n"
//        default:
//            infoText += "**\(counterAlreadyInData)** of these contents are already stored in your app.\n\n"
//        }
//        
//        switch counterNewData {
//        case 0:
//            infoText += "Therefore we did not import any new content to your app."
//        case 1:
//            infoText += "Therefore we imported **\(counterNewData)** content to the app."
//        default:
//            infoText += "Therefore we imported **\(counterNewData)** contents to the app."
//        }
//        
//        await showInfoMessage(infoText)
    }
    
    func addContentEntry(name: String, creator: String?, category: ContentCategories, contentEntry: ContentEntry) {
        contentEntry.content = fetchOrCreateContent(name: name, creator: creator, category: category)
        modelContext.insert(contentEntry)
    }
    
    func fetchOrCreateContent(name: String, creator: String?, category: ContentCategories) -> ContentMedia {
        let descriptor = FetchDescriptor<ContentMedia>(
            sortBy: [SortDescriptor(\.name, order: .reverse)]
        )
        
        for item in fetchContents() {
            if item.contentCategory == category {
                if item.name == name {
                    return item
                }
            }
        }
        
        let contentMedia = ContentMedia(
            name: name,
            contentCategory: category,
            createdBy: creator == nil ? [] : [fetchOrCreateCreator(for: creator!)]
        )
        modelContext.insert(contentMedia)
        return contentMedia
    }
    
    func fetchOrCreateCreator(for name: String) -> Creator {
        for creator in fetchCreators() {
            if creator.name == name {
                return creator
            }
        }
        
        let creator = Creator(name: name)
        modelContext.insert(creator)
        return creator
    }
    
    
    func deleteContent(content: ContentEntry) {
        modelContext.delete(content)
    }
    
    func deleteAllMediaContent() async {
        let deletedBooks = await deleteAllContentForCategory(contentCategory: .books, showMessage: false)
        let deletedMovies = await deleteAllContentForCategory(contentCategory: .movies, showMessage: false)
        let deletedSeries = await deleteAllContentForCategory(contentCategory: .series, showMessage: false)
        
        let numOfDeletions = deletedBooks+deletedMovies+deletedSeries
        switch numOfDeletions {
        case 0:
            await showInfoMessage("There was no content to delete.")
        case 1:
            await showInfoMessage("We deleted **1** entry from your app.")
        default:
            await showInfoMessage("We deleted **\(numOfDeletions)** entries from your app.")
        }
    }
    
    
    func deleteAllContentForCategory(contentCategory: ContentCategories, showMessage: Bool = true) async -> Int {
        var numOfDeletions = 0
        switch contentCategory {
        case .books:
            let books = fetchContentEntries().filter({$0.content?.contentCategory == .books})
            numOfDeletions = books.count
            for book in books {
                deleteContent(content: book)
            }
        case .movies:
            let books = fetchContentEntries().filter({$0.content?.contentCategory == .movies})
            numOfDeletions = books.count
            for book in books {
                deleteContent(content: book)
            }
        case .series:
            let books = fetchContentEntries().filter({$0.content?.contentCategory == .series})
            numOfDeletions = books.count
            for book in books {
                deleteContent(content: book)
            }
        }
        
        if !showMessage {
            return numOfDeletions
        }
        
        switch numOfDeletions {
        case 0:
            await showInfoMessage("There was no content to delete.")
        case 1:
            await showInfoMessage("We deleted **1 \(contentCategory.getSingularName())** from your app.")
        default:
            await showInfoMessage("We deleted **\(numOfDeletions) \(contentCategory.getName())** from your app.")
        }
        
        return numOfDeletions
    }
}
