//
//  LinkContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.05.24.
//

import SwiftUI

fileprivate var googleUrl: String = "https://www.google.com/search?q="

struct LinkContent: View {
    let contentFor: String
    
    var body: some View {
        HStack.spacingS(alignment: .bottom) {
            Text("Google")
                .font(.headline)
            
            Text(contentFor)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            if let url = URL(string: googleUrl+contentFor) {
                Link(destination: url) {
                    Image(systemName: "rectangle.portrait.and.arrow.forward")
                        .bold()
                }
            }
        }
    }
}
