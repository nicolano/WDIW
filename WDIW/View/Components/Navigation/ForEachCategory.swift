//
//  ForEachCategory.swift
//  WDIW
//
//  Created by Nicolas von Trott on 15.05.24.
//

import SwiftUI

struct ForEachCategory<Content: View>: View {
    @ViewBuilder let content: (ContentCategories) -> Content
    
    var body: some View {
        ForEach(ContentCategories.iterator, id: \.self) { category in
            content(category)
        }
    }
}
