//
//  AddContentSheet.swift
//  WDIW
//
//  Created by Nicolas von Trott on 21.02.24.
//

import SwiftUI

struct AddContentSheet: View {
    @Environment(\.dismiss) var dismiss
    
    let contentCategory: ContentCategories
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            Spacer()
        }
    }
}

extension AddContentSheet {
    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Back")
            }
            
            Spacer()
            
            Group {
                Text("Add ")
                +
                Text(contentCategory.getSingularName())
            }
                .bold()

            Spacer()
            
            Button {
                
            } label: {
                Text("Save")
                    .bold()
            }
        }
        .padding(.Spacing.m)
        .background(Color.Custom.surface)
    }
}

#Preview {
    Rectangle()
        .sheet(isPresented: .constant(true)) {
            AddContentSheet(
                contentCategory: ContentCategories.books
            ) 
        }
}
