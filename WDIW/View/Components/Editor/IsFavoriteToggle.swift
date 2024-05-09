//
//  IsFavoriteToggle.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct IsFavoriteToggle: View {
    init(value: Binding<Bool>, title: String? = nil) {
        self._value = value
        self.title = title
    }
    
    @Binding var value: Bool
    private let title: String?
    
    var body: some View {
        HStack {
            if let title = title {
                Text(title)
                    .bold()
            }
            
            Spacer()
            
            FavButton(isActive: value) {
                value.toggle()
            }
        }
    }
}
