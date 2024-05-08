//
//  ConentViewModel.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation
import SwiftData

class ContentViewModel: ObservableObject {
    var modelContext: ModelContext
    @Published var mediaContents = [MediaContent]()
    @Published var movies = [Movie]()
    @Published var books = [Book]()
    @Published var series = [Series]()
    
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
                sortBy: [SortDescriptor(\.watchDate)]
            )
            movies = try modelContext.fetch(descriptor)
            mediaContents.append(contentsOf: movies)
        } catch {
            print("Fetch for movies failed.")
        }
    }
    
    func fetchBooksData() {
        do {
            let descriptor = FetchDescriptor<Book>(
                sortBy: [SortDescriptor(\.entryDate)]
            )
            books = try modelContext.fetch(descriptor)
            mediaContents.append(contentsOf: movies)
        } catch {
            print("Fetch for books failed.")
        }
    }
    
    func fetchSeriesData() {
        do {
            let descriptor = FetchDescriptor<Series>(
                sortBy: [SortDescriptor(\.entryDate)]
            )
            series = try modelContext.fetch(descriptor)
            mediaContents.append(contentsOf: movies)
        } catch {
            print("Fetch for series failed.")
        }
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
    
    func deleteAllData() {
        modelContext.container.deleteAllData()
    }

    func writeToFile() {
        
    }
}
