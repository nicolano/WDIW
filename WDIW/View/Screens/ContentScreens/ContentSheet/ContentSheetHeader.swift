//
//  ContentSheetHeader.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct ContentSheetHeader: View {
    let title: String
    let contentEntry: ContentEntry
    let type: ContentSheetType
    let onDismiss: () -> Void
    let onSave: () -> Void
    let onCategoryChange: (ContentCategories) -> Void
    
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
                
                switch type {
                case .ADD:
                    Menu {
                        ForEachCategory { category in
                            Button {
                                onCategoryChange(category)
                            } label: {
                                Text(category.getSingularName())
                            }
                        }
                    } label: {
                        Text(contentEntry.content?.contentCategory?.getSingularName() ?? "")
                        Image(systemName: "chevron.compact.down")
                            .offset(x: -5)
                    }
                case .EDIT:
                    Text(contentEntry.content?.contentCategory?.getSingularName() ?? "")
                }
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
            .disabled(!contentEntry.isValid)
        }
        .padding(.Spacing.m)
        .background(Color.Custom.surface)
    }
}
