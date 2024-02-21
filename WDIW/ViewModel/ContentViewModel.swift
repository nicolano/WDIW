//
//  ConentViewModel.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import Foundation
import SwiftData

class ContentViewModel: ObservableObject {
//    @Environment(\.modelContext) private var modelContext
    @Published var books: [Book] = []
    @Published var movies: [Movie] = []
    @Published var series: [Series] = []
//
//    
//    private func addContent(_ content: Content) {
//        withAnimation {
//            modelContext.insert(newItem)
//        }
//    }

    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
    }
}
