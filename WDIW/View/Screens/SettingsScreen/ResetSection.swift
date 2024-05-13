//
//  ResetSection.swift
//  WDIW
//
//  Created by Nicolas von Trott on 09.05.24.
//

import SwiftUI

struct ResetSection: View {
    @EnvironmentObject private var contentVM: ContentViewModel
    
    @State private var showingDeleteAllDataAlert = false
    @State private var showingDeleteAllBooksAlert = false
    @State private var showingDeleteAllMoviesAlert = false
    @State private var showingDeleteAllSeriesAlert = false

    var body: some View {
        Section(
            header: Text("Reset"),
            footer: Text("These actions cannot be undone, so be careful!")
        ) {
            deleteAllData
            deleteAllBooks
            deleteAllMovies
            deleteAllSeries
        }
        .headerProminence(.increased)
    }
}

extension ResetSection {
    private var deleteAllData: some View {
        Button {
            showingDeleteAllDataAlert = true
        } label: {
            Label(
                title: { Text("Delete all data") },
                icon: { Image(systemName: "trash.fill") }
            )
            .foregroundStyle(Color.red)
        }
        .alert(
            "Are you sure you want to delete all data?",
            isPresented: $showingDeleteAllDataAlert
        ) {
            Button("No", role: .cancel) {
                showingDeleteAllDataAlert = false
            }
            
            Button("Yes", role: .destructive) {
                Task { await contentVM.deleteAllMediaContent() }
            }
        }
    }
    
    private var deleteAllBooks: some View {
        Button {
            showingDeleteAllBooksAlert = true
        } label: {
            Label(
                "Delete all books",
                systemImage: ContentCategories.books.getIconName(isActive: false)
            )
        }
        .alert(
            "Are you sure you want to delete all books?",
            isPresented: $showingDeleteAllBooksAlert
        ) {
            Button("No", role: .cancel) {
                showingDeleteAllBooksAlert = false
            }
            
            Button("Yes", role: .destructive) {
                Task { await contentVM.deleteAllContentForCategory(contentCategory: .books) }
            }
        }
    }
    
    private var deleteAllMovies: some View {
        Button {
            showingDeleteAllMoviesAlert = true
        } label: {
            Label(
                "Delete all movies",
                systemImage: ContentCategories.movies.getIconName(isActive: false)
            )
        }
        .alert(
            "Are you sure you want to delete all movies?",
            isPresented: $showingDeleteAllMoviesAlert
        ) {
            Button("No", role: .cancel) {
                showingDeleteAllMoviesAlert = false
            }
            
            Button("Yes", role: .destructive) {
                Task { await contentVM.deleteAllContentForCategory(contentCategory: .movies) }
            }
        }
    }
    
    private var deleteAllSeries: some View {
        Button {
            showingDeleteAllSeriesAlert = true
        } label: {
            Label(
                "Delete all series",
                systemImage: ContentCategories.series.getIconName(isActive: false)
            )
        }
        .alert(
            "Are you sure you want to delete all series?",
            isPresented: $showingDeleteAllSeriesAlert
        ) {
            Button("No", role: .cancel) {
                showingDeleteAllSeriesAlert = false
            }
            
            Button("Yes", role: .destructive) {
                Task { await contentVM.deleteAllContentForCategory(contentCategory: .series) }
            }
        }
    }
}
