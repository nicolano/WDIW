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
    
    @Published var movies = [Movie]()
    @Published var books = [Book]()
    @Published var series = [Series]()
    
    var mediaContents: [MediaContent] {
        var mediaContents = books.map({$0 as MediaContent})
        mediaContents.append(contentsOf: movies.map({$0 as MediaContent}))
        mediaContents.append(contentsOf: series.map({$0 as MediaContent}))
        return mediaContents
    }
    
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
        self.fetchData()
    }
    
    func fetchData() {
        fetchBooksData()
        fetchMoviesData()
        fetchSeriesData()
    }
        
    func fetchMoviesData() {
        do {
            let descriptor = FetchDescriptor<Movie>(
                sortBy: [SortDescriptor(\.date)]
            )
            movies = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch for movies failed.")
        }
    }
    
    func fetchBooksData() {
        do {
            let descriptor = FetchDescriptor<Book>(
                sortBy: [SortDescriptor(\.date)]
            )
            books = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch for books failed.")
        }
    }
    
    func fetchSeriesData() {
        do {
            let descriptor = FetchDescriptor<Series>(
                sortBy: [SortDescriptor(\.date)]
            )
            series = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch for series failed.")
        }
    }
    
    func importContents(contents: [MediaContent]) async {
        var counterNewData: Int = 0
        var counterAlreadyInData: Int = 0
        for content in contents {
            if !mediaContents.map({$0.id}).contains(content.id) {
                addContent(content: content)
                counterNewData += 1
            } else {
                counterAlreadyInData += 1
            }
        }
        
        var infoText = ""
        
        switch contents.count {
        case 0:
            await showErrorMessage("We did not find any content in your file.")
            return
        case 1:
            infoText += "We found **\(contents.count)** content in your file.\n\n"
        default:
            infoText += "We found **\(contents.count)** contents in your file.\n\n"
        }
                
        switch counterAlreadyInData {
        case 0:
            ()
        case 1:
            infoText += "**\(counterAlreadyInData)** of these contents is already stored in your app.\n\n"
        default:
            infoText += "**\(counterAlreadyInData)** of these contents are already stored in your app.\n\n"
        }
        
        switch counterNewData {
        case 0:
            infoText += "Therefore we did not import any new content to your app."
        case 1:
            infoText += "We imported **\(counterNewData)** content to the app."
        default:
            infoText += "We imported **\(counterNewData)** contents to the app."
        }
        
        await showInfoMessage(infoText)
    }
    
    func addContent(content: MediaContent) {
        switch content {
        case is Book:
            modelContext.insert(content as! Book)
            fetchBooksData()
        case is Movie:
            modelContext.insert(content as! Movie)
            fetchMoviesData()
        case is Series:
            modelContext.insert(content as! Series)
            fetchSeriesData()
        default:
            print("Content type could not be inferred.")
        }
    }

    func deleteContent(content: MediaContent) {
        switch content {
        case is Book:
            modelContext.delete(content as! Book)
            fetchBooksData()
        case is Movie:
            modelContext.delete(content as! Movie)
            fetchMoviesData()
        case is Series:
            modelContext.delete(content as! Series)
            fetchSeriesData()
        default:
            print("Content type could not be inferred.")
        }
    }
    
    func deleteAllMediaContent() {
        deleteAllContentForCategory(contentCategory: .books)
        deleteAllContentForCategory(contentCategory: .movies)
        deleteAllContentForCategory(contentCategory: .series)
    }
    
    func deleteAllContentForCategory(contentCategory: ContentCategories) {
        switch contentCategory {
        case .books:
            for book in books {
                deleteContent(content: book)
            }
        case .movies:
            for movie in movies {
                deleteContent(content: movie)
            }
        case .series:
            for serie in series {
                deleteContent(content: serie)
            }
        }
    }
}
