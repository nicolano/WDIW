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
        self.content = contentCategory.getEmptyContent
    }
    
    internal init(content: MediaContent) {
        self.type = .EDIT
        self.content = content
    }
    
    let type: ContentSheetType
    @State var content: MediaContent
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
        switch content {
        case is Book:
            contentScreenVMs.forBooks.addContent(content: content)
        case is Movie:
            contentScreenVMs.forMovies.addContent(content: content)
        case is Series:
            contentScreenVMs.forSeries.addContent(content: content)
        default:
            return
        }
    }
    
    func onDelete() {
        switch content {
        case is Book:
            contentScreenVMs.forBooks.deleteContent(content: content)
        case is Movie:
            contentScreenVMs.forMovies.deleteContent(content: content)
        case is Series:
            contentScreenVMs.forSeries.deleteContent(content: content)
        default:
            return
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ContentSheetHeader(title: title, content: content, type: type) {
                dismiss()
            } onSave: {
                onSave()
                navigationVM.navigateToContentCategory(category: ContentCategories.getCategoryFor(mediaContent: content))
                dismiss()
            } onCategoryChange: { category in
                self.content = category.getEmptyContent
            }
            
            ContentSwitch(content: $content) { book in
                EditBookContent(book: book)
            } movieContent: { movie in
                EditMovieContent(movie: movie)
            } seriesContent: { series in
                EditSeriesContent(series: series)
            }
                        
            if type == .EDIT {
                DeleteButton {                        
                    showDeleteContentAlert = true
                }
                .padding(.TopL)
                .padding(.HorizontalM)
                .alert(
                    "Are you sure you want to delete \"\(content.name)\"?",
                    isPresented: $showDeleteContentAlert
                ) {
                    Button("No", role: .cancel) {
                        showDeleteContentAlert = false
                    }
                    
                    Button("Yes", role: .destructive) {
                        onDelete()
                        navigationVM.closeSelectedContentHero()
                        navigationVM.navigateToContentCategory(category: ContentCategories.getCategoryFor(mediaContent: content))
                        dismiss()
                    }
                }
            }
            
            Spacer()
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
                            ContentSheet(content: it)
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
