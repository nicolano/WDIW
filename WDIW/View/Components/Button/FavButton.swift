//
//  FavButton.swift
//  WDIW
//
//  Created by Nicolas von Trott on 09.05.24.
//

import SwiftUI

struct FavButton: View {
    let isActive: Bool
    let onPress: () -> Void
    
    @State private var animateScale: Double = 1

    var body: some View {
        Button {
            onPress()
        } label: {
            Image(systemName: isActive ? "star.fill" : "star")
                .foregroundStyle(Color.yellow)
                .scaleEffect(animateScale)
        }
        .sensoryFeedback(.selection, trigger: isActive)
        .onChange(of: isActive) { oldValue, newValue in
            if newValue == false {
                return
            }
            
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
