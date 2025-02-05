//
//  ContentSheet.swift
//  WDIW
//
//  Created by Nicolas von Trott on 12.05.24.
//

import SwiftUI

enum ContentSheetType {
    case ADD, EDIT
}

struct ContentSheet: View {
    @EnvironmentObject private var contentScreenVMs: ContentScreenViewModels
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    internal init(contentCategory: ContentCategories) {
        self.type = .ADD
        self.contentEntry = ContentEntry.getEmptyFor(category: contentCategory)
    }
    
    internal init(contentEntry: ContentEntry) {
        self.type = .EDIT
        self.contentEntry = contentEntry
    }
    
    let type: ContentSheetType
    @State var contentEntry: ContentEntry
    @State var name: String = ""
    @State var creator: String = ""
    @State var showDeleteContentAlert: Bool = false
    
    var title: String {
        switch type {
        case .ADD:
            "Add"
        case .EDIT:
            "Edit"
        }
    }
    
    func onSave() {
        switch contentEntry.content?.contentCategory {
        case .books:
            contentScreenVMs.forBooks.addContent(contentEntry: contentEntry)
        case .movies:
            contentScreenVMs.forMovies.addContent(contentEntry: contentEntry)
        case .series:
            contentScreenVMs.forSeries.addContent(contentEntry: contentEntry)
        case nil:
            return
        }
    }
    
    func onDelete() {
        switch contentEntry.content?.contentCategory {
        case .books:
            contentScreenVMs.forBooks.deleteContent(content: contentEntry)
        case .movies:
            contentScreenVMs.forMovies.deleteContent(content: contentEntry)
        case .series:
            contentScreenVMs.forSeries.deleteContent(content: contentEntry)
        case nil:
            return
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ContentSheetHeader(title: title, contentEntry: contentEntry, type: type) {
                dismiss()
            } onSave: {
                onSave()
                navigationVM.navigateToContentCategory(category: contentEntry.content?.contentCategory ?? .books)
                dismiss()
            } onCategoryChange: { category in
                self.contentEntry = ContentEntry.getEmptyFor(category: category)
            }
            
            ContentSwitch(content: $contentEntry) { book in
                EditBookContent(name: <#T##Binding<String>#>, author: <#T##Binding<String>#>, userNotes: <#T##Binding<String>#>, date: <#T##Binding<Date>#>, isFavorite: <#T##Binding<Bool>#>)
            } movieContent: { movie in
                EditMovieContent(movie: movie)
            } seriesContent: { series in
                EditSeriesContent(series: series)
            }
              
            Spacer(minLength: 0)
            
            if type == .EDIT {
                DeleteButton {                        
                    showDeleteContentAlert = true
                }
                .padding(.VerticalS)
                .padding(.HorizontalM)
                .alert(
                    "Are you sure you want to delete \"\(contentEntry.content?.name ?? "")\"?",
                    isPresented: $showDeleteContentAlert
                ) {
                    Button("No", role: .cancel) {
                        showDeleteContentAlert = false
                    }
                    
                    Button("Yes", role: .destructive) {
                        onDelete()
                        navigationVM.closeSelectedContentHero()
                        navigationVM.navigateToContentCategory(category: contentEntry.content?.contentCategory ?? .books)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ContentSheetViewModifier: ViewModifier {
    @EnvironmentObject private var navigationVM: NavigationViewModel

    let type: ContentSheetType
    
    func body(content: Content) -> some View {
        content
            .sheet(
                isPresented: Binding(
                    get: {
                        switch type {
                        case .ADD:
                            navigationVM.activeAddContentSheet != nil
                        case .EDIT:
                            navigationVM.activeEditContentSheet != nil
                        }
                    }, 
                    set: { dismiss in
                        switch type {
                        case .ADD:
                            navigationVM.closeAddContentSheet()
                        case .EDIT:
                            navigationVM.closeEditContentSheet()
                        }
                    }
                ),
                content: {
                    switch type {
                    case .ADD:
                        if let it = navigationVM.activeAddContentSheet {
                            ContentSheet(contentCategory: it)
                        }
                    case .EDIT:
                        if let it = navigationVM.activeEditContentSheet {
                            ContentSheet(contentEntry: it)
                        }
                    }
                }
            )
    }
}

extension View {
    func contentSheet(type: ContentSheetType) -> some View {
        modifier(ContentSheetViewModifier(type: type))
    }
}
