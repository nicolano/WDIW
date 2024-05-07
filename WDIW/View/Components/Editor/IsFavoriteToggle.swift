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
    
    @State private var animateScale: Double = 1
    
    var body: some View {
        HStack {
            if let title = title {
                Text(title)
                    .bold()
            }
            
            Spacer()
            
            Button {
                value.toggle()
            } label: {
                Image(systemName: value ? "star.fill" : "star")
                    .foregroundStyle(Color.yellow)
                    .scaleEffect(animateScale)
            }
        }
        .sensoryFeedback(.selection, trigger: value)
        .onChange(of: value) { oldValue, newValue in
            withAnimation {
                animateScale = 1.4
            } completion: {
                withAnimation {
                    animateScale = 1.0
                }
            }
        }
    }
}
