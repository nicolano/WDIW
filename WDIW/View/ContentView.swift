//
//  ContentView.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI
import SwiftData



struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var books: [Book]
//    @Query private var movies: [Movie]
//    @Query private var series: [Series]

    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            
            Spacer()
        }
        .overlay {
            VStack {
                Spacer()
                
                TabBar()
                    .padding(.horizontal, .Spacing.m)
            }
        }
    }

    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
    }

    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
