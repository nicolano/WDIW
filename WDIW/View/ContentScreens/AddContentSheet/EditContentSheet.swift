//
//  EditContentSheet.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct EditContentSheet: View {
    @EnvironmentObject private var contentVM: ContentViewModel
    @Environment(\.dismiss) var dismiss
        
    @State var content: MediaContent
    
    private var contentCategory: ContentCategories {
        ContentCategories.getCategoryFor(mediaContent: content)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ContentSheetHeader(title: "Edit", content: content) {
                dismiss()
            } onSave: {
                contentVM.addContent(content: content)
            }
                        
            ContentSwitch(content: $content) { book in
                EditBookContent(book)
            } movieContent: { movie in
                EditMovieContent(movie)
            } seriesContent: { series in
                EditSeriesContent(series)
            }
            
            DeleteButton {
                contentVM.deleteContent(content: content)
                dismiss()
            }
            .padding(.TopL)
            .padding(.HorizontalM)
            
            Spacer()
        }
    }
}

struct EditContentSheetViewModifier: ViewModifier {
    @EnvironmentObject private var contentVM: ContentViewModel
    @EnvironmentObject private var navigationVM: NavigationViewModel

    func body(content: Content) -> some View {
        ZStack {
            content
                .sheet(isPresented: Binding(get: {
                    navigationVM.activeEditContentSheet != nil
                }, set: { dismiss in
                    if !dismiss {
                        navigationVM.closeEditContentSheet()
                    }
                }), content: {
                    if let it = navigationVM.activeEditContentSheet {
                        EditContentSheet(content: it)
                    }
                })
        }
    }
}

extension View {
    func editContentSheet() -> some View {
        modifier(EditContentSheetViewModifier())
    }
}
