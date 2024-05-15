//
//  Header.swift
//  WDIW
//
//  Created by Nicolas von Trott on 21.02.24.
//

import SwiftUI

struct Header<Content1: View, Content2: View, Content3: View>: View {
    let title: String
    @ViewBuilder let tertiaryButton: Content1
    @ViewBuilder let secondaryButton: Content2
    @ViewBuilder let primaryButton: Content3
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.black)
            
            Spacer()
            
            tertiaryButton
            
            secondaryButton
            
            primaryButton
        }
        .padding(.horizontal, .Spacing.l)
        .padding(.top, .Spacing.m)
        .padding(.bottom, .Spacing.m)
        .frame(height: 70)
    }
}
