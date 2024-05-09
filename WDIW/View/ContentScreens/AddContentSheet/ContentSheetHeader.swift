//
//  ContentSheetHeader.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct ContentSheetHeader: View {
    let title: String
    let content: MediaContent
    let onDismiss: () -> Void
    let onSave: () -> Void
    
    var body: some View {
        HStack {
            Button {
                onDismiss()
            } label: {
                Text("Back")
            }
            
            Spacer()
            
            Group {
                Text(title)
                +
                Text(" ")
                +
                Text(ContentCategories.getCategoryFor(mediaContent: content).getSingularName())
            }
            .bold()

            Spacer()
            
            Button {
                onSave()
                onDismiss()
            } label: {
                Text("Save")
                    .bold()
            }
            .disabled(!content.isValid)
        }
        .padding(.Spacing.m)
        .background(Color.Custom.surface)
    }
}
