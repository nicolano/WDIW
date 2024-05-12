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
    @EnvironmentObject private var contentVM: ContentViewModel
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
    
    var title: String {
        switch type {
        case .ADD:
            "Add"
        case .EDIT:
            "Edit"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ContentSheetHeader(title: title, content: content) {
                dismiss()
            } onSave: {
                contentVM.addContent(content: content)
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
                    contentVM.deleteContent(content: content)
                    dismiss()
                }
                .padding(.TopL)
                .padding(.HorizontalM)
            }
            
            Spacer()
        }
    }
}

struct ContentSheetViewModifier: ViewModifier {
    @EnvironmentObject private var navigationVM: NavigationViewModel

    let type: ContentSheetType
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .sheet(isPresented: Binding(get: {
                    switch type {
                    case .ADD:
                        navigationVM.activeAddContentSheet != nil
                    case .EDIT:
                        navigationVM.activeEditContentSheet != nil
                    }
                }, set: { dismiss in
                    switch type {
                    case .ADD:
                        navigationVM.closeAddContentSheet(dismiss)
                    case .EDIT:
                        navigationVM.closeEditContentSheet(dismiss)
                    }
                }), content: {
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
                })
        }
    }
}

extension View {
    func contentSheet(type: ContentSheetType) -> some View {
        modifier(ContentSheetViewModifier(type: type))
    }
}
